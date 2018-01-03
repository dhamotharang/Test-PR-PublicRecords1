import emerges, data_services;

EXPORT key_override_hunting_fishing := module
	fname_prefix := '~thor_data400::base::override::fcra::qa::';
	daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  keyname_prefix := data_services.data_location.prefix() + 'thor_data400::key::override::fcra::hunting_fishing::qa::';

//New	
	// shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	// shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
	// shared keyname_prefix := '~thor_data400::key::override::fcra::hunt:qa::';

  hunt_rec := RECORD
		emerges.layout_hunters_out;
    string20 flag_file_id;
  end;

  ds_hunt := dataset (fname_prefix + 'hunting_fishing', hunt_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')), OPT);
	dailyds_hunt := dataset (daily_prefix + 'hunting_fishing', hunt_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')), OPT);
  kf := dedup (sort (ds_hunt, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_hunt,persistent_record_id,replaceds);
  export hunting_fishing := index (kf, {flag_file_id}, {kf}, keyname_prefix + 'ffid', OPT);
	
// New 	
  // ds_hunt := dataset (fname_prefix + 'hunting_fishing', hunt_rec, flat, OPT);
	// dailyds_hunt := dataset (daily_prefix + 'hunting_fishing', hunt_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  // kf := dedup (sort (ds_hunt, -flag_file_id), except flag_file_id);
	// FCRA.Mac_Replace_Records(kf,dailyds_hunt,persistent_record_id,replaceds);
  // export hunting_fishing := index (kf, {flag_file_id}, {kf}, keyname_prefix + 'ffid', OPT);

end;