import Doxie, Risk_Indicators, LN_PropertyV2, ut;

boolean include_hri := false : stored('IncludeHRI');
unsigned1 maxHriPer_value := 10 : stored('MaxHriPer');
MAX_FARES_LIMIT := 100;

EXPORT layout_AddressPresentation Location_apn_presentation (String apn) := FUNCTION

	clean_apn := LN_PropertyV2.fn_strip_pnum(apn);

  fare_id_assesors := LIMIT (LN_PropertyV2.key_assessor_parcelnum (fares_unformatted_apn = clean_apn), 
                             MAX_FARES_LIMIT, FAIL (203, doxie.ErrorCodes(203)));
  fare_id_deeds    := LIMIT (LN_PropertyV2.key_deed_parcelnum (fares_unformatted_apn = clean_apn),
                             MAX_FARES_LIMIT, FAIL (203, doxie.ErrorCodes(203)));
	
  fares_id := fare_id_assesors + fare_id_deeds;
  // we don't really expect duplicates here, so deduping is made later for all addresses.
  // fares_dpd := DEDUP (SORT (fares_id, ln_fares_id), ln_fares_id);

  layout_AddressPresentation getAddress (recordof(LN_PropertyV2.key_search_fid()) R) := TRANSFORM
    SELF := R;
    SELF := [];
  END;

  addrs := JOIN (fares_id, LN_PropertyV2.key_search_fid(),
                 keyed (Left.ln_fares_id = Right.ln_fares_id) AND
                 Right.source_code_2 = 'P',
                 getAddress (Right));

  // for apn search penalty is (should be) always 0, hence no sorting by penalty;
  fare_addresses := DEDUP (SORT (addrs, zip, prim_name, prim_range, sec_range), 
                           zip, prim_name, prim_range, sec_range);

  Doxie.mac_AddHRIAddress (fare_addresses, outfile);
  recs := if(include_hri, outfile, fare_addresses);
	
	layout_AddressPresentation shrinkrecs(layout_AddressPresentation L) := transform
		self.hri_address	:= choosen(L.hri_address,	consts.max_hri_addr);
		self.rids					:= choosen(L.rids,				consts.max_rids);
		self := L;
	end;
	
  results := project(recs, shrinkRecs(left));
	
	doxie.MAC_Header_Field_Declare();
	results_s := sort(results, penalt,ut.StringSimilar100(sec_range_value,sec_range), zip, prim_name, (INTEGER)prim_range, sec_range, record);
	
	return results_s;
END;