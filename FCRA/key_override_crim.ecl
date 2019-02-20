import corrections, data_services, ut, hygenics_crim;
/*
// existing overrides (in the layout different from regular keys)
FCRA.Key_Override_Crim_Offender_FFID
~thor_data400::key::override::fcra::criminal_offender::qa::ffid
*/

export key_override_crim := MODULE

  shared fname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::base::override::fcra::qa::';
	shared daily_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::crim::qa::';

	//offenders --- override for doxie_files.key_offenders
  export offenders_rec := record
	  string20 flag_file_id;
		corrections.layout_Offender;
    //... or recordof (doxie_files.key_offenders_OffenderKey (true));
    //... or recordof (doxie_files.key_offenders (true));
  end;

  ds_offenders := dataset (fname_prefix + 'offenders', offenders_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_offenders := dataset (daily_prefix + 'offenders', offenders_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_offenders, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_offenders,offender_persistent_id,replaceds);  
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::crim::qa::offenders
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, hygenics_crim.constants('').fields_to_clear_offenders);  
  export offenders := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'offenders');
	
	//offenders plus --- override for doxie_files.key_offenders_offenderKey
  ds_offenders_plus := dataset (fname_prefix + 'offenders_plus', offenders_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_offenders_plus := dataset (daily_prefix + 'offenders_plus', offenders_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_offenders_plus, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_offenders_plus,offender_persistent_id,replaceds);  
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::crim::qa::offenders_plus
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, hygenics_crim.constants('').fields_to_clear_offenders);  
  export offenders_plus := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'offenders_plus');
	
  // offenses
  offenses_rec := record
	  string20 flag_file_id;
    corrections.layout_offense - offense_category;
    //... or recordof (doxie_files.key_offenses (true));
  end;

  ds_offenses := dataset (fname_prefix + 'offenses', offenses_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_offenses := dataset (daily_prefix + 'offenses', offenses_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_offenses, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_offenses,offense_persistent_id,replaceds);  
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::crim::qa::offenses
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, hygenics_crim.constants('').fields_to_clear_offender_key);  
  export offenses := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'offenses');

  //court_offenses
  court_offenses_rec := record
	  string20 flag_file_id;
    corrections.layout_CourtOffenses - offense_category;
    //... or recordof (doxie_files.key_court_offenses (true));
  end;

  ds_court_offenses := dataset (fname_prefix + 'court_offenses', court_offenses_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  dailyds_court_offenses := dataset (daily_prefix + 'court_offenses', court_offenses_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_court_offenses, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_court_offenses,offense_persistent_id,replaceds);  
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::crim::qa::courtoffenses
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, hygenics_crim.constants('').fields_to_clear_court_offenses + ',sent_date');
  export court_offenses := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'courtoffenses');

  // punishment
  punishment_rec := record
	  string20 flag_file_id;
    corrections.Layout_CrimPunishment;
    //... or recordof (doxie_files.key_punishment);
  end;

  ds_punishment := dataset (fname_prefix + 'punishment', punishment_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  dailyds_punishment := dataset (daily_prefix + 'punishment', punishment_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_punishment, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_punishment,punishment_persistent_id,replaceds); 
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::crim::qa::punishment
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, hygenics_crim.constants('').fields_to_clear_punishment_type);
  export punishment := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'punishment');

  // activity
  activity_rec := record
	  string20 flag_file_id;
    corrections.layout_activity;
    //... or recordof (doxie_files.key_activity);
  end;

  ds_activity := dataset (fname_prefix + 'activity', activity_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_activity := dataset (daily_prefix + 'activity', activity_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_activity, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_activity,activity_persistent_id,replaceds);
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::crim::qa::activity
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, 'off_comp');  
  export activity := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'activity');

END;