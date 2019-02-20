import data_services, marriage_divorce_v2, ut;

// TODO: OPT options should be removed from basefile and index definitions;
//       'temp' should be removed from index names

// Any record definitions can be exported, if needed
export key_override_marriage := MODULE

  shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::';
	
  // marriage record
  marriage_main_rec := RECORD
    marriage_divorce_v2.layout_mar_div_base_slim;
    string20 flag_file_id;
  end;

  ds_marriage_main := dataset (fname_prefix + 'marriage_main', marriage_main_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_marriage_main := dataset (daily_prefix + 'marriage_main', marriage_main_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_marriage_main, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_marriage_main,persistent_record_id,replaceds);
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::marriage_main::qa::ffid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, marriage_divorce_v2.fn_FCRA_Field_Deprecation.fields_to_clear_id_main);
  export marriage_main := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'marriage_main::qa::ffid', OPT);


  // party records
  export marriage_search_rec := RECORD
    marriage_divorce_v2.layout_mar_div_search;
    string20 flag_file_id;
  end;

  ds_marriage_search := dataset (fname_prefix + 'marriage_search', marriage_search_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_marriage_search := dataset (daily_prefix + 'marriage_search', marriage_search_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_marriage_search, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_marriage_search,persistent_record_id,replaceds);
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::marriage_search::qa::ffid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, marriage_divorce_v2.fn_FCRA_Field_Deprecation.fields_to_clear_id_search);
  export marriage_search := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'marriage_search::qa::ffid', OPT);

END;
