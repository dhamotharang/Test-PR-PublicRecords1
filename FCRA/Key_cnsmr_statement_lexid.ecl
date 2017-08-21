import bankruptcyv2, address, ut, data_services;


  
	
	fname_prefix := '~thor_data400::base::override::fcra::qa::';
	daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  keyname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::';
	

  // lexid_rec := RECORD
    // layout_lexid;
    // string20 flag_file_id;
  // end;

  ds_lexid := dataset (fname_prefix + 'consumerstatement_lexid', FCRA.Layout_Override_CnsmrStmt_In, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_lexid := dataset (daily_prefix + 'consumerstatement_lexid', FCRA.Layout_Override_CnsmrStmt_In, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_lexid, lexid), record);
	FCRA.Mac_Replace_Records(kf,dailyds_lexid,lexid,replaceds);
  export key_cnsmr_statement_lexid := index (replaceds, {lexid}, {replaceds}, keyname_prefix + 'consumerstatement::qa::lexid');


// export key_cnsmr_statement_lexid := index (proj_lexid, {lexid}, {proj_lexid}, 
// data_services.data_location.prefix('fcra_overrides')+'~thor_data400::key::override::consumerstatement::qa::lexid');


