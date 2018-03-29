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
	integer FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided, 
	boolean rollup_by_case_link = false
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

  // Get the relevant key_liens_main_id(_fcra) info.  We may wish to do case linking
  //   and reduction prior to extracting case and history data
  fn_get_main_recs(main_key_in) := functionmacro
    local layout := { recordof(liensv2.key_liens_main_id_fcra), string30 acctno };
		return join(tmsids_cln, main_key_in, keyed(left.tmsid = right.tmsid), 
			transform(layout, self.acctno := left.acctno, self := right), limit(10000));
  endmacro;

  local_liens_main_recs := if(IsFCRA, fn_get_main_recs(liensv2.key_liens_main_id_fcra), 
  	fn_get_main_recs(liensv2.key_liens_main_id));

  // Call fn_link_liens_cases to add case_link_id to the records
  local_linked_main_recs := LiensV2_Services.fn_link_liens_cases(local_liens_main_recs, true, acctno);

  // incorporate case linking id and priority values in a common format
  local_liens_format := record
		recordof(local_liens_main_recs);
		string case_link_id := '';
		unsigned case_link_priority := 0;
  end;
  local_proj_recs := project(local_linked_main_recs, transform(local_liens_format, 
  	self.case_link_id := (string)left.case_link_id, 
		self := left));

  // if we aren't doing case linking, we want blank case_link fields
  final_main_recs := if(rollup_by_case_link, local_proj_recs, 
		project(local_liens_main_recs, local_liens_format));

  // Get case data from our recs
  layout_liens_case_extended xf_case_copy(final_main_recs l) := transform
    self.acctno := l.acctno;
		self.filing_status := choosen(l.filing_status,10);
		self.filing_jurisdiction_name := LiensV2_Services.fn_get_filing_jurisdiction_name(l.filing_jurisdiction);
		self := l;
	end;
	ds_case_raw := project(final_main_recs, xf_case_copy(left));

	// filter by jurisdiction if provided
	// TODO: Jurisdiction filter may need to be applied to history records as well 
	//   (or to final_main_recs before case and history records are gathered)
	ds_case_filt := if(in_filing_jurisdiction <> '', 
		ds_case_raw(in_filing_jurisdiction in [filing_jurisdiction,filing_state,agency_state]),
		ds_case_raw);

	// FILING INFO COPY TRANSFORM
  layout_liens_history_extended xf_history_copy(final_main_recs l) := transform
		self.acctno  := l.acctno;
		self.tmsid   := l.tmsid;
		self.case_link_id       := l.case_link_id;
		self.case_link_priority := l.case_link_priority;
		self.filings := dataset([{l.filing_number, l.filing_type_desc, l.orig_filing_date, l.filing_date, l.filing_time, l.filing_book, l.filing_page,
			l.agency, l.agency_state, l.agency_city, l.agency_county, l.persistent_record_id, 
			DATASET([], FFD.Layouts.StatementIdRec), false, l.bcbflag, l.case_link_priority}],
			recordof(layout_liens_history_extended.filings));
	end;
	ds_history_raw := project(final_main_recs, xf_history_copy(left));
	
  RETURN LiensV2_Services.GetCRSOutput (ds_party_raw_pre, ds_case_filt, ds_history_raw, in_ssn_mask_type, 
		IsFCRA, person_filter_id, return_multiple_pages, 
		includeCriminalIndicators, ds_slim_pc, inFFDOptionsMask, FCRAPurpose);

end;