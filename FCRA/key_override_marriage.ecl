import data_services, marriage_divorce_v2, ut;

// TODO: OPT options should be removed from basefile and index definitions;
//       'temp' should be removed from index names

// Any record definitions can be exported, if needed
export key_override_marriage := MODULE

  shared fname_prefix := data_services.data_location.prefix('marriage') + 'thor_data400::base::override::fcra::qa::';
	shared daily_prefix := data_services.data_location.prefix('marriage') + 'thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix('marriage') + 'thor_data400::key::override::fcra::';
	
  // marriage record
  marriage_main_rec := RECORD
    marriage_divorce_v2.layout_mar_div_base_slim;
    string20 flag_file_id;
  end;

  ds_marriage_main := dataset (fname_prefix + 'marriage_main', marriage_main_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_marriage_main := dataset (daily_prefix + 'marriage_main', marriage_main_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_marriage_main, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_marriage_main,persistent_record_id,replaceds);
  export marriage_main := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'marriage_main::qa::ffid', OPT);


  // party records
  marriage_search_rec := RECORD
    marriage_divorce_v2.layout_mar_div_search;
    string20 flag_file_id;
  end;

  ds_marriage_search := dataset (fname_prefix + 'marriage_search', marriage_search_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_marriage_search := dataset (daily_prefix + 'marriage_search', marriage_search_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_marriage_search, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_marriage_search,persistent_record_id,replaceds);
  export marriage_search := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'marriage_search::qa::ffid', OPT);

END;
