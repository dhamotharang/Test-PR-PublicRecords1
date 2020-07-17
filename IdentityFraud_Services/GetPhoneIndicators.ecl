IMPORT $, doxie, iesp, Risk_Indicators, moxie_phonesplus_server;

ifr := iesp.identityfraudreport;

// fictitious dataset representing Gong entry, when it is not included into the header yet
$.layouts.slim_header CreateGongEntry () := transform
  Self.src := 'PH';
  Self._type := 'PHONE';
  Self := []; // don't care about anything else
end;
ph_fabricated := dataset ([CreateGongEntry ()]);

EXPORT GetPhoneIndicators (
  dataset (doxie.layout_best) bestrecs,
  dataset ($.layouts.slim_header) header_recs,
  $.IParam._identityfraudreport param) := FUNCTION

  mod_access := PROJECT(param, Doxie.IDataAccess, OPT);

  // ===================================================================
  // =========================== Get phones  ===========================
  // ===================================================================
  phones_header_rec := doxie.layout_presentation - recordof (doxie.key_header);
  phones_hri_rec := record
    // couldn't find any layout suitable for using in doxie/mac_AddHRIPhone
    phones_header_rec and not [penalt, num_compares, glb, dppa];
    doxie.key_header.did;
    doxie.key_header.phone;
    doxie.key_header.prim_range;
    doxie.key_header.predir;
    doxie.key_header.prim_name;
    doxie.key_header.sec_range;
    doxie.key_header.st;
    doxie.key_header.zip;
    doxie.key_header.lname;
    doxie.key_header.listed_name;

    boolean is_phonesplus; // to differentiate Gong from PhonesPlus
    DATASET(Risk_Indicators.Layout_Desc) hri_Phone {maxcount ($.Constants.MAX_HRI)} := dataset ([], Risk_Indicators.Layout_Desc);
  end;


  // take only header records with same address as a best file: make it easier for Roxie
  ds_in := join (header_recs, bestrecs,
                 Left.did = Right.did and
                 Left.prim_name = Right.prim_name and
                 Left.prim_range = Right.prim_range and
                 Left.predir=Right.predir and
                 //NB: exact match: TODO: check if it's better to ease it on sec range
                 Left.sec_range = Right.sec_range and
//                 ut.nneq (Left.sec_range, Right.sec_range) and
                 (Left.zip = Right.zip),
                 transform (doxie.layout_presentation, Self := Left, Self := []),
                 limit (0), keep (1)); // inner
  //looks like doxie/Append_Gong really needs just these fields: did, phone, prim_range, prim_name, sec_range, st, zip, hhid


  // -------------------------------------------------------------------
  // First, fetch Gong phones, explicitely excluding PP
  // -------------------------------------------------------------------
  all_gong_phones := doxie.Append_Gong(ds_in,
    doxie.relative_dids(project(bestrecs, doxie.layout_references)),
    mod_access,
    ,// integer dcp_value = 5
    false, //do not include PhonesPlus phones
    param.score_threshold);

  // TODO: check whether Append_Gong can bring phones at completely different addresses,
  // then I will have to make an extra join with best records here

  // now get all phones together, dedup (for each DID); skip some not reliable phones
  // HRI for each Gong phone will be calculated in the context of "this" person's address nad name
  phones_hri_rec GetPhones (doxie.layout_presentation_phones L, doxie.layout_phones R) := transform, SKIP (R.match_type = 0)
      // TODO: I also can get other things from Gong phones: score, match_type, phone_first_seen, publish_code, etc.
      Self.phone := R.phone10;
      Self.listed_name := R.listed_name;
      Self.timezone := R.timezone; //? listed_timezone
      Self.phonetype := R.phonetype; // Mobile, etc.
      Self.carrier := R.carrier;
      Self.carrier_city := R.carrier_city;
      Self.carrier_state := R.carrier_state;

      Self.listing_type_res := R.listing_type_res;
      Self.listing_type_bus := R.listing_type_bus;
      Self.listing_type_gov := R.listing_type_gov;
      Self.listing_type_cell:= R.listing_type_cell;
      Self.is_phonesplus := false;
      Self.hri_Phone := [];
      Self := L; // did, address components, lname
  end;
  gong_phones := normalize (all_gong_phones, Left.phones, GetPhones (Left, Right));


  // save whatever phone's data we need
  phones_hri_rec SetPhoneData (phones_hri_rec L, phones_hri_rec R) := transform
    // 0-dates are ignored
    Self.phone_first_seen := if (R.phone_first_seen < L.phone_first_seen, R.phone_first_seen, L.phone_first_seen);
    Self.hri_Phone := [];
    Self := L;
  end;
  phones_gong_hri := rollup (sort (gong_phones, did, phone, -phone_last_seen),
                           (Left.did = Right.did) and (Left.phone = Right.phone),
                           SetPhoneData (Left, Right));




  // -------------------------------------------------------------------
  // Second, attach phones from PhonesPlus
  // -------------------------------------------------------------------
  phplRecs := moxie_phonesplus_server.phonesplus_did_records (
            project (bestrecs, doxie.layout_references),
            iesp.Constants.BR.MaxPhonesPlus,
            param.score_threshold,
            param.glb,
            param.dppa,, TRUE).w_timezoneSeenDt; //isRoxie

  pp_rec := recordof (phplRecs);

  // rollup by did+phone //TODO: what else?
  pp_rec RollPhonesPlus (pp_rec L, pp_rec R) := transform
    Self.first_seen := if (L.first_seen = 0 or L.first_seen > R.first_seen, R.first_seen, L.first_seen);
    Self := L;
  end;
  pp_rolled := rollup (sort (phplRecs, did, phoneno, -last_seen),
                       (Left.did=Right.did) and (Left.phoneno = Right.phoneno),
                       RollPhonesPlus (Left, Right));

  phones_hri_rec CreatePhonesPlus (pp_rec L) := transform
    Self.phone := L.phoneno;
    Self.listed_name := L.listed_name;
    Self.did := (integer) L.did;
    Self.zip := L.z5;
    Self.lname := L.name_last;
    Self.phone_first_seen := L.first_seen;
    Self.phone_last_seen := L.last_seen;
    Self.hri_Phone := dataset ([], Risk_Indicators.Layout_Desc);

    Self.is_phonesplus := true;
    Self := L; // address components, listed_stuff
  end;
  phones_plus_hri := project (pp_rolled, CreatePhonesPlus (Left));

  // get Gong and PP together
  phones_hri_pre := phones_gong_hri + if (param.include_phonesplus, phones_plus_hri);

  maxHriPer_value := param.max_hri;
  doxie.mac_AddHRIPhone (phones_hri_pre, phones_hri, mod_access);


  // ===================================================================
  // ====================== Get header phones counts ===================
  // ===================================================================
  // When counting phones (found in Gong) in header file we need to consider the following:
  //   count must include "Gong" source; since Gong and header updated at a different time,
  //   I will always fabricate additional gong entry in the header,
  //   which will be deduped if Gong entry is already there.

  // NB: listed_phone field is blank in header, except daily
  header_pre_phones := group (sort (header_recs (phone != ''), did, phone, src), did, phone);

  phone_count_rec := record
    unsigned6 did;
    string10 phone;
    unsigned2 count;
    dataset (ifr.t_IFRLinkIdSources) Sources {MAXCOUNT(iesp.Constants.IFR.MaxIndicators)};
    header_pre_phones.not_in_bureau; // always zero for phones
  end;

  phone_count_rec GetHeaderPhonesCounts ($.layouts.slim_header L, dataset ($.layouts.slim_header) R) := transform
    Self.did := L.did;
    Self.phone := L.phone;
    // get source categories' counts.  Add fabricated Gong entry (in case if it's not there)
    Self.Sources := choosen ($.Functions.GetSources (R + ph_fabricated), iesp.Constants.IFR.MaxSourcetypes);
    // overal count:
    Self.count := if (param.count_by_source, count (dedup (R, src, all)), count (Self.Sources));
    Self.not_in_bureau := L.not_in_bureau;
    // dates in the header are not relevant to phones
  end;
  phones_counted := rollup (header_pre_phones, group, GetHeaderPhonesCounts (left, rows (left)));



  // ===================================================================
  // ====================== Get phones' counts =========================
  // ===================================================================

  // For the time being all phones from phones+ will have source "PHONE" and count=1
  // Gong phones will use header for counts.
  ifr.t_IFRLinkIdSources AdjustPhoneForGong (ifr.t_IFRLinkIdSources L) := transform
    Self.Count := if (L._Type = 'PHONE', L.Count +1, L.Count);
    Self._Type := L._Type;
  end;

  $.layouts.phone_did_rec SetCounts (phones_hri_rec L, phone_count_rec R) := transform
    Self.did := L.did;
    Self.Phone10 := L.phone;
    Self.ListedName := L.listed_name;
    Self.timezone := L.timezone;
    Self.PhoneType := L.phonetype;
    Self.CarrierName := L.carrier;
    Self.CarrierCity := L.carrier_city;
    Self.CarrierState := L.carrier_state;
    ltypes := dataset ([{L.listing_type_res}, {L.listing_type_bus}, {L.listing_type_gov}, {L.listing_type_cell}],
                       iesp.share.t_StringArrayItem);
    Self.ListingTypes := ltypes (Value != '');
    // patch for the case when no phones were found in header (phones_counted is empty in this case)
    // also hardcode sources and counts for PP-phones for the time being; temporarily set PHONES+ source
    Self.Sources := if (L.is_phonesplus,
                        dataset ([{'PHONE', 1}], ifr.t_IFRLinkIdSources),
                        if (R.count = 0, $.Functions.GetSources (ph_fabricated), R.Sources));
    Self.Sourcecount := if (R.count = 0 or L.is_phonesplus, 1, R.count);

    Self.DateFirstSeen := iesp.ECL2ESP.toDateYM (L.phone_first_seen);
    Self.DateLastSeen := iesp.ECL2ESP.toDateYM (L.phone_last_seen);

    // take previously calculated RIs
    all_inds := project (L.hri_phone, $.Functions.TransformRiskIndicators (Left));
    selected_inds := choosen (sort (all_inds, -all_inds.Rank), $.Constants.MAX_PHONES_INDICATORS);
    Self.RiskIndicators := if (exists (L.hri_phone), selected_inds);
  end;

  // A precaution: Gong and Phones+ phones must not intersect, in theory, but to be on the safe side
  // dedup seems to be appropriate.
  // Also, I can't yet tell if a phone is from header or "other" source whithin phones+ data.
  // For the simplicity sake, I will discard a duplicate coming from Gong
  phones_ddp := dedup (sort (phones_hri, did, phone, ~is_phonesplus), did, phone);

  // attach header-counts to the phones, increment for Gong, transform to (almost) esdl
  phones_ready := join (phones_ddp, phones_counted,
                        (Left.did = Right.did) and (Left.phone = Right.phone),
                        SetCounts (Left, Right),
                        LEFT OUTER, keep (1), limit (0));


  // NB: return unrolled records
  return phones_ready;
END;
