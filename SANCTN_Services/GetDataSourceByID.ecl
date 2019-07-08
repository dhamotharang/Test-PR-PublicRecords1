﻿// ========================================================
// Returns SANCTN info from the source file; used as both search and report.
// Result is: 
//   penalized (if search);
//   masked in relation to SSN mask;
//   ? pulled by ssn ?
//   embedded table "party" is sorted by party name
// ========================================================

IMPORT census_data, codes, doxie, SANCTN, Sanctn_Services, STD, suppress, ut;

shared OUT_REC := Sanctn_Services.layouts.SourceOutput;

doxie.MAC_Header_Field_Declare (); // unfortunately: only to get input city name! Should be gone after interfaces are done

shared GetBestCity (string25 vcity, string25 pcity) := MAP (
  vcity = '' => pcity, 
  pcity = '' => vcity,
  ut.StringSimilar (vcity, city_value) <= ut.StringSimilar (pcity, city_value) => vcity, pcity
);

// For full report in_ids here contains one is at most!
EXPORT out_rec GetDataSourceByID (GROUPED DATASET (Sanctn_Services.layouts.id) in_ids,
                                  doxie.IDataAccess mod_access) := FUNCTION

  in_rec := RECORDOF (SANCTN.Key_sanctn_incident);
  // Fetch common info, calculating penalty for every record.
  in_rec GetIncidentInfo (SANCTN.Key_sanctn_incident L) := TRANSFORM
    SELF := L;
  END;
  // CCPA no DID or personal info in key
  src_fetched := JOIN (in_ids, SANCTN.Key_sanctn_incident,
                       keyed (Left.batch_number = Right.batch_number) AND
                       keyed (Left.incident_number = Right.incident_number),
                       transform (in_rec, SELF := Right),
                       KEEP (Constants.INCIDENT_RECORDS_MAX)); // 1:M relation

  // rollup Incident info 
  inc_sort := SORT (src_fetched, RECORD, except order_number, incident_text);
  inc_grp := GROUP (inc_sort, RECORD, except order_number, incident_text);

  Sanctn_Services.layouts.Incident RollIncidentInfo (inc_grp L, DATASET (in_rec) all_recs) := TRANSFORM
    // roll incident info: concatenate text which comes without breaks in order_number;
    IncInfo := Sanctn_Services.layouts.IncidentInfo;
    info_data := CHOOSEN (all_recs, Constants.TEXT_PER_INCIDENT);
    info_proj := PROJECT (info_data, transform (IncInfo, Self.order_number := (unsigned2) Left.order_number, Self := Left)); 
    info_srt := SORT (info_proj, order_number);

    IncInfo RollText (IncInfo L, IncInfo R) := transform
      self.order_number := R.order_number; // note, this is not original sequence number anymore
      // unfortunately, both needs to be trimmed...   
      self.incident_text := (trim (L.incident_text) + trim (R.incident_text))[1..SANCTN_Services.Constants.incident_text_length];
    end;
    info_rolled := ROLLUP (info_srt, (Left.order_number + 1 = Right.order_number), RollText (Left, Right));
    // assign new sequence number
    IncInfo AssignSequence (IncInfo L, integer C) := transform
      self.order_number := C;
      self.incident_text := L.incident_text;
    end; 
    SELF.info := PROJECT (info_rolled, AssignSequence (Left, COUNTER));
    SELF := L;
  END;
  inc_compact_all := ROLLUP (inc_grp, GROUP, RollIncidentInfo (Left, ROWS (Left)));



	// retrieve parties: each party may have multiple entries here, depending on the number of parts in party info
	party_subset_all := join(
		inc_compact_all, SANCTN.Key_SANCTN_party,
		keyed(left.batch_number=right.batch_number) and keyed(left.incident_number=right.incident_number),
		transform(SANCTN_Services.layouts.layoutSanctnClean, self:=right),
		limit(Constants.PARTY_PER_INCIDENT,skip)
	);   

  party_subset := Suppress.MAC_FlagSuppressedSource(party_subset_all, mod_access); 

  // ---------------------------------------------------------------------
  // First roll each party's texts
  party_srt := SORT (party_subset, batch_number, incident_number, party_number);
  party_grp := GROUP (party_srt, batch_number, incident_number, party_number);

  Sanctn_Services.layouts.rec_party_plusIsSupp RollPartyInfo (SANCTN_Services.layouts.layoutSanctnCleanPlusIsSupp L, DATASET (SANCTN_Services.layouts.layoutSanctnCleanPlusIsSupp) all_recs) := transform
    SELF.name := L;

    // set state
    SELF.address.state := STD.STR.ToUpperCase (codes.general.state_long (L.st));
    // county full name calculated after
    SELF.address.county := '';
    SELF.address := L;
      
    // slim down to party text
    PartyInfo := Sanctn_Services.layouts.PartyInfo;
    info_data := CHOOSEN (all_recs, Constants.TEXT_PER_PARTY);
    info_proj := PROJECT (info_data, transform (PartyInfo, Self.order_number := (unsigned2) Left.order_number,
                                                           Self.party_text := Left.party_text)); 

    //roll up party info by paragraphs
    info_srt := SORT (info_proj, order_number);
    PartyInfo RollText (PartyInfo L, PartyInfo R) := transform
      self.order_number := R.order_number; // note, this is not original sequence number anymore: just the latest
      self.party_text := trim (L.party_text) + trim (R.party_text);
    end;
    SELF.info := ROLLUP (info_srt, (Left.order_number + 1 = Right.order_number), RollText (Left, Right));

    // "clean" vendor's snn -- return only digits, if any
    SELF.SSNUMBER := IF (L.SSNUMBER != '', STD.STR.FilterOut (L.SSNUMBER,'- '), '');

    // penalize:
    addr_penalt := doxie.FN_Tra_Penalty_Addr (L.predir, L.prim_range, L.prim_name, L.addr_suffix,
                                              L.postdir, L.sec_range, 
                                              GetBestCity (L.v_city_name, L.p_city_name),
                                              L.st, L.zip5);
    SELF.penalt := addr_penalt +  doxie.FN_Tra_Penalty_Name (L.fname, L.mname, L.lname) + doxie.FN_Tra_Penalty_CName (L.cname);

    SELF := L;
  end;
  party_info_rolled := ROLLUP (party_grp, GROUP, RollPartyInfo (Left, ROWS (Left)));


  // Now have only unique parties;
  // pull, mask, add county name
	Suppress.MAC_Suppress(party_info_rolled,party_pulled,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,SSNUMBER);
	Suppress.MAC_Mask(party_pulled, party_masked, SSNUMBER, blank, true, false, maskVal:=mod_access.ssn_mask);
  census_data.MAC_Fips2County_Keyed (party_masked, address.st, address.fips_county, address.county, party_cleaned)

  // Roll parties into child dataset
  prt_grp := GROUP (sort (UNGROUP (party_cleaned), batch_number, incident_number), batch_number, incident_number);

  rec_parties_rolled := RECORD
    SANCTN.layout_SANCTN_party_in.batch_number;
    SANCTN.layout_SANCTN_party_in.incident_number;
    unsigned1 penalt;
    DATASET (Sanctn_Services.layouts.Party) parties {MAXCOUNT (Sanctn_Services.Constants.PARTY_PER_INCIDENT)};
    BOOLEAN is_suppressed;
  END; 

  rec_parties_rolled RollParties (prt_grp L, DATASET (recordof (prt_grp)) all_recs) := transform
    sortBySuppress := SORT(all_recs, -is_suppressed); // bring any "TRUE" is_suppressed recs to top
    Self.parties := project (all_recs, Sanctn_Services.layouts.Party);
    // minimal penalty among all party entities (people/companies)
    Self.penalt := MIN (all_recs, penalt);
    Self.is_suppressed := sortBySuppress[1].is_suppressed;
    Self := L;
  end;
  party_ready := rollup (prt_grp, GROUP, RollParties (Left, ROWS (Left)));


  // add party info
  OUT_REC AppendParty (Sanctn_Services.layouts.IncidentPlusIsSupp L, rec_parties_rolled R) := TRANSFORM

    // NB: sort uses "uncleaned" party name, since it has both people and companies
    SELF.parties := SORT (R.parties, party_name);
    SELF.penalt := R.penalt;
    SELF := L;
  END;

  inc_compact := JOIN(inc_compact_all, party_ready,
                      Left.batch_number=Right.batch_number and 
                      Left.incident_number = Right.incident_number,
                      TRANSFORM(SANCTN_Services.layouts.IncidentPlusIsSupp,
                        self.is_suppressed := RIGHT.is_suppressed,
                        self := LEFT),
                      LEFT OUTER, keep(1), limit (0));
                        
  // ds_party := PROJECT (inc_compact, GetPartyInfo (Left));
  ds_res := JOIN (inc_compact(~is_suppressed), party_ready,
                  Left.batch_number=Right.batch_number and 
                  Left.incident_number = Right.incident_number,
                  AppendParty (Left, Right),
                  LEFT OUTER, keep (1), limit (0)); // at most 1 match

  // output (inc_compact, named ('inc_compact'), all);
  // output (party_info_rolled, named ('party_info_rolled'), all);
  //output (party_ready, named ('party_ready'), all);
  return ds_res;

END;
