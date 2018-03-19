import BIPV2, doxie, doxie_cbrs, UCCv2, FCRA, FFD;

// This module provides UCC data in different formats.
export UCCRaw := module

  // Gets RMSIDs from TMSIDs
	export get_rmsids_from_tmsids(dataset(UCCv2_Services.layout_tmsid) in_tmsids) := function
	  key := UCCV2.Key_Rmsid_Main ();
		res := join(dedup(sort(in_tmsids,tmsid),tmsid),key,
		            keyed(left.tmsid = right.tmsid),
								transform(UCCv2_Services.layout_rmsid,self := right),
								limit(10000,skip));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;
	
	// Gets RMSIDs from DIDs
	// FCRA: this function is for producing internal IDs, no overrides required
	export get_rmsids_from_dids(dataset(doxie.layout_references) in_dids,string1 in_party_type = '') := function
	  key := uccv2.key_did_w_Type ();
		res := join(dedup(sort(in_dids,did),did),key,
		            keyed(left.did = right.did) and
								keyed(in_party_type='' or right.party_type=in_party_type),
								transform(UCCv2_Services.layout_rmsid,self := right),
								limit(10000,skip));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;

	// Gets RMSIDs from BDIDs
	export get_rmsids_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
	                             unsigned in_limit = 0, boolean isMoxie = false,
															 string1 in_party_type = '') := function
	  key := UCCV2.Key_Bdid_w_Type;
		res_r := join(dedup(sort(in_bdids,bdid),bdid),key,
		            keyed(left.bdid = right.bdid) and
								keyed(in_party_type='' or right.party_type=in_party_type),
								transform(UCCv2_Services.layout_rmsid,self := right),
								limit(10000,skip));
		res_m := join(dedup(sort(in_bdids,bdid),bdid),key,
		            keyed(left.bdid = right.bdid) and
								keyed(in_party_type='' or right.party_type=in_party_type),
								transform(UCCv2_Services.layout_rmsid,self := right),
								limit(500,skip));
		res := if(isMoxie,res_m,res_r);
		ded := dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;

	// Gets RMSIDs from Filing Number
	export get_rmsids_from_Filing_Number(dataset(UCCv2_Services.layout_filing_number) in_filing_number) := function
		key := UCCV2.Key_filing_number;
		res := join(dedup(sort(in_filing_number,filing_number),filing_number),key,
								keyed(left.filing_number = right.filing_number),
								transform(UCCv2_Services.layout_rmsid, self := right),
								limit(1000,skip));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;

	// Gets RMSIDs from FEIN
	export get_rmsids_from_FEIN(dataset(UCCv2_Services.layout_fein) in_fein) := function
		key := UCCV2.Key_Fein;
		res := join(dedup(sort(in_fein,fein),fein),key,
								keyed(left.fein = right.fein),
								transform(UCCv2_Services.layout_rmsid, self := right),
								limit(1000,skip));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;
	
	// Gets TMSIDs from DIDs
	// FCRA: this function is for producing internal IDs, no overrides required
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_dids(dataset(doxie.layout_references) in_dids,
															string1 in_party_type = ''
															) := function
		key := uccv2.key_did_w_Type ();
		res := join(dedup(sort(in_dids,did),did),key,
								keyed(left.did = right.did) and
								keyed(in_party_type='' or right.party_type=in_party_type),
								transform(UCCv2_Services.layout_tmsid, self := right),
								limit(1000,skip));
		
		return dedup(sort(res,tmsid),tmsid);
	end;

	// Gets TMSIDs from BDIDs
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
	                             unsigned in_limit = 0,
															 string1 in_party_type = '') := function
		key := UCCV2.Key_Bdid_w_Type;
		res := join(dedup(sort(in_bdids,bdid),bdid),key,
								keyed(left.bdid = right.bdid) and
								keyed(in_party_type='' or right.party_type=in_party_type),
								transform(UCCv2_Services.layout_tmsid, self := right),
								limit(1000,skip));
		ded := dedup(sort(res,tmsid),tmsid);
		
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;

  EXPORT get_tmsids_from_linkIds(dataset(BIPV2.IDlayouts.l_xlink_ids) in_linkIds,
															   string1 businessIdFetchLevel,
	                               unsigned in_limit = 0,
															   string1 in_party_type = '') := FUNCTION

		// *** Key fetch to get ucc tmsids from linkids
		ds_ucclink := UCCv2.Key_LinkIds.KeyFetch(in_linkIds, businessIdFetchLevel);
															
		ds_ucckeys := PROJECT(ds_ucclink(party_type != 'A'),
																TRANSFORM(UCCv2_Services.layout_tmsid,
																					SELF := LEFT));																			
																					
																					
		ded := dedup(sort(ds_ucckeys, tmsid), tmsid);

		RETURN if(in_limit = 0, ded, choosen(ded,in_limit));																
	END;

	// Gets TMSIDs from RMSIDs
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_rmsids(dataset(UCCv2_Services.layout_rmsid) in_rmsids) := function
	  key := UCCV2.Key_Rmsid;
		res := join(dedup(sort(in_rmsids,rmsid),rmsid),key,
		            keyed(left.rmsid = right.rmsid),
								transform(UCCv2_Services.layout_rmsid, self := right),
								limit(1000,skip));
		
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;
	
  // Returns UCC data in Legacy format (matches old-style UCC)
  export legacy_view := module
	
	  // ...using TMSIDs as the lookup mechanism.
		export raw_by_tmsid(
			dataset(UCCv2_services.layout_tmsid) in_tmsids,
			string in_ssn_mask_type = ''
		) := function
		  return UCCv2_services.Legacy.fn_getUCC_legacy_raw(in_tmsids, in_ssn_mask_type);
		end;

	  // ...using TMSIDs/Levels as the lookup mechanism.
		export raw_with_levels(
			dataset(UCCv2_services.Legacy.layout_levelRec) in_levels,
			string in_ssn_mask_type = ''
		) := function
		  return UCCv2_services.Legacy.fn_getUCC_legacy_rawLevels(in_levels, in_ssn_mask_type);
		end;

	  // ...using TMSIDs as the lookup mechanism.
		export by_tmsid(
			dataset(UCCv2_services.layout_tmsid) in_tmsids,
			string in_ssn_mask_type = ''
		) := function
		  return UCCv2_services.Legacy.fn_getUCC_legacy(in_tmsids, in_ssn_mask_type);
		end;

	  // ...using DIDs as the lookup mechanism.
	  export by_did(dataset(doxie.layout_references) in_dids,
		              string in_ssn_mask_type = '',
									string1 in_party_type = '') := function
		  return by_tmsid(get_tmsids_from_dids(in_dids,in_party_type),in_ssn_mask_type);
		end;
		
		// ...using BDIDs as the lookup mechanism.
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
		               unsigned in_limit = 0,
		               string in_ssn_mask_type = '',
									 string1 in_party_type = '') := function
		  return by_tmsid(get_tmsids_from_bdids(in_bdids,in_limit,in_party_type),in_ssn_mask_type);
		end;
		
		// ...using both DIDs & BDIDs as the lookup mechanism.
		export by_both_ids(
			dataset(doxie.layout_references) in_dids,
			dataset(doxie_cbrs.layout_references) in_bdids,
			string in_ssn_mask_type = '',
			string1 in_party_type = '') := function
			
		  tmsids := dedup(
				get_tmsids_from_dids(in_dids,in_party_type)
					+ get_tmsids_from_bdids(in_bdids,0,in_party_type),
				record,
				all
			);
			
		  return by_tmsid(tmsids,in_ssn_mask_type);
		end;
	end;
	
  // Returns UCC data in the report summary view (grouped and rolled up by TMSID)
  export report_view := module
	
	  // ...using TMSIDs as the lookup mechanism.
		export by_tmsid(
			dataset(UCCv2_services.layout_tmsid) in_tmsids,
			string in_ssn_mask_type = ''
		) := function
		  return UCCv2_services.fn_getUCC_tmsid (in_tmsids, in_ssn_mask_type);
		end;

	  // ...using DIDs as the lookup mechanism.
	  export by_did(dataset(doxie.layout_references) in_dids,
		              string in_ssn_mask_type = '',
									string1 in_party_type = ''
		) := function
			tmsids := get_tmsids_from_dids(in_dids,in_party_type);
			res := by_tmsid(tmsids,in_ssn_mask_type);
		  return res;
		end;

		// ...using BDIDs as the lookup mechanism.
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
		               unsigned in_limit = 0,
		               string in_ssn_mask_type = '',
									 string1 in_party_type = ''
									 ) := function
		  return by_tmsid(get_tmsids_from_bdids(in_bdids,in_limit,in_party_type),in_ssn_mask_type);
		end;
	end;

	// Returns UCC data in the source view (grouped and rolled up by RMSID)
	export source_view := module
	
	  // ...using rmsids as a lookup mechanism.
		export by_rmsid(
			dataset(UCCv2_services.layout_rmsid) in_rmsids,
			string in_ssn_mask_type,
			BOOLEAN return_multiple_pages = FALSE,
			string32 appType
		) := function
		  return UCCv2_Services.fn_getUCC_rmsid(in_rmsids, in_ssn_mask_type, return_multiple_pages,appType);
		end;
		
		// ...using tmsids as a lookup mechanism.
		export by_tmsid(
			dataset(UCCv2_services.layout_tmsid) in_tmsids,
			string in_ssn_mask_type = '',
			BOOLEAN return_multiple_pages = FALSE,
			string32 appType
		) := function
		  return by_rmsid(get_rmsids_from_tmsids(in_tmsids), in_ssn_mask_type, return_multiple_pages,appType);
		end;
		
		// ...using dids as a lookup mechanism.
		export by_did(
			dataset(doxie.layout_references) in_dids,
			string in_ssn_mask_type = '',
			string1 in_party_type = '',
			string32 appType
		) := function
		  return by_rmsid(get_rmsids_from_dids(in_dids,in_party_type), in_ssn_mask_type, false, appType);
		end;
		
		// ...using bdids as a lookup mechanism.
		export by_bdid(
			dataset(doxie_cbrs.layout_references) in_bdids,
			unsigned in_limit = 0,
			string in_ssn_mask_type = '',
			string1 in_party_type = '',
			string32 appType
		) := function
		  return by_rmsid(get_rmsids_from_bdids(in_bdids,in_limit,,in_party_type), in_ssn_mask_type, false, appType);
		end;
	end;

end;