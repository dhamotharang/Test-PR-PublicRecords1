// FUNCTION TO GET LIENS FROM A SET OF TMSID

//IMPORTANT FCRA-NOTE:
//  Corresponding FCRA-compliant/neutral data are used here,
//  fcra-corrections, if required by a service, should be applied to the output result by a caller

import liensv2, FFD, FCRA;
export fn_get_liens_tmsid(
  grouped dataset(liensv2_services.layout_tmsid) in_tmsids, //grouped by 'accto'
	string in_ssn_mask_type,
  boolean IsFCRA = FALSE,
	string in_filing_jurisdiction = '',
	string person_filter_id = '',
	BOOLEAN return_multiple_pages = FALSE,
	string32 appType,
  boolean includeCriminalIndicators = FALSE,
	DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0,
	integer FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided
) := function

	// 	GET PARTY INFO FIRST FOR PULL IDS
  MAC_GetPartyInfo (trans_name, key_attr, out_file) := MACRO
	liensv2_services.layout_lien_party_raw trans_name (in_tmsids l, key_attr r) := transform
	  self.acctno := l.acctno;
    self.hasCriminalConviction := false;
    self.isSexualOffender := false;
	  self := r;
	end;
	out_file := join (in_tmsids, key_attr,
                    keyed(left.tmsid = right.tmsid),
                    trans_name (left,right),
                    limit(10000));
  ENDMACRO;
  MAC_GetPartyInfo (xf_party_copy, liensv2.key_liens_party_id, ds_party);
  MAC_GetPartyInfo (xf_party_copy_fcra, liensv2.key_liens_party_id_fcra, ds_party_fcra);
  ds_party_raw_pre := IF (IsFCRA, ds_party_fcra, ds_party);

  // cannot use pullSSN in fcra-side: overrides should be used for the same purpose
  ds_pulled := project(liensv2_services.fn_pullIDs(ds_party_raw_pre,appType), liensv2_services.layout_tmsid);
	tmsids_cln := DEDUP(SORT(IF (IsFCRA, UNGROUP (project(ds_party_raw_pre, liensv2_services.layout_tmsid)), ds_pulled),tmsid),tmsid);


  // JOIN TMSID SET TO INDEX TO GET DATA
  MAC_CaseCopy (trans_name, key_attr, out_file) := MACRO
//  temp_case_layout trans_name (tmsids_cln l, key_attr r) := transform
  layout_liens_case_extended trans_name (tmsids_cln l, key_attr r) := transform
    self.acctno := l.acctno;
		self.filing_status := choosen(r.filing_status,10);
	  self.filing_jurisdiction_name := LiensV2_Services.fn_get_filing_jurisdiction_name(r.filing_jurisdiction);
	  self := r;
	end;
  out_file := join (tmsids_cln, key_attr, 
                    keyed(left.tmsid = right.tmsid), 
										trans_name (left,right),
                    limit(10000));
  ENDMACRO;
  MAC_CaseCopy (xf_case_copy,      liensv2.key_liens_main_id,      ds_case);
  MAC_CaseCopy (xf_case_copy_fcra, liensv2.key_liens_main_id_fcra, ds_case_fcra);
  ds_case_raw := IF (IsFCRA, ds_case_fcra, ds_case);

	// filter by jurisdiction if provided
	ds_case_filt := if(in_filing_jurisdiction <> '', 
														ds_case_raw(in_filing_jurisdiction in [filing_jurisdiction,filing_state,agency_state]),
														ds_case_raw);

	// FILING INFO COPY TRANSFORM
  MAC_FilingsCopy (trans_name, key_attr, out_file) := MACRO
  layout_liens_history_extended trans_name (liensv2_services.layout_tmsid l, key_attr r) := transform
		self.acctno  := l.acctno;
		self.tmsid   := r.tmsid;
	  self.filings := dataset([{r.filing_number, r.filing_type_desc, r.orig_filing_date, r.filing_date, r.filing_time, r.filing_book, r.filing_page,
															r.agency, r.agency_state, r.agency_city, r.agency_county, r.persistent_record_id, DATASET([], FFD.Layouts.StatementIdRec), false, r.bcbflag}],
															liensv2_services.layout_lien_history_w_bcb);
	end;
  out_file := join (tmsids_cln, key_attr,
                    keyed(left.tmsid = right.tmsid),
										trans_name (left,right),
                    limit(0));
  ENDMACRO;
  MAC_FilingsCopy (xf_history_copy,      liensv2.key_liens_main_id,      ds_history);
  MAC_FilingsCopy (xf_history_copy_fcra, liensv2.key_liens_main_id_fcra, ds_history_fcra);
  ds_history_raw := IF (IsFCRA, ds_history_fcra, ds_history);
	
  RETURN LiensV2_Services.GetCRSOutput (ds_party_raw_pre, ds_case_filt, ds_history_raw, in_ssn_mask_type, 
																				IsFCRA, person_filter_id, return_multiple_pages, 
																				includeCriminalIndicators, ds_slim_pc, inFFDOptionsMask, FCRAPurpose);

end;