import emerges, data_services;

EXPORT key_override_ccw := module
	shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::concealed_weapons::qa::';
	
//New	
	// shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	// shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
	// shared keyname_prefix := '~thor_data400::key::override::fcra::ccw:qa::';
	

	export ccw_rec := RECORD
    emerges.layout_ccw_out;
    string20 flag_file_id;
  end;

	ds_ccw := dataset (fname_prefix + 'concealed_weapons', ccw_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')), OPT);
	dailyds_ccw := dataset (daily_prefix + 'concealed_weapons', ccw_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')), OPT);
  kf := dedup (sort (ds_ccw, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_ccw,persistent_record_id,replaceds);

  replaceds_dep := FCRA.fDeprecate_Fields_CCW(replaceds);  //Field deprecation 

  export concealed_weapons := index (replaceds_dep, {flag_file_id}, {replaceds_dep}, keyname_prefix + 'ffid', OPT);
  
//New	
	// ds_ccw := dataset (fname_prefix + 'concealed_weapons', ccw_rec, flat, OPT);
	// dailyds_ccw := dataset (daily_prefix + 'concealed_weapons', ccw_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  // kf := dedup (sort (ds_ccw, -flag_file_id), except flag_file_id);
	// FCRA.Mac_Replace_Records(kf,dailyds_ccw,persistent_record_id,replaceds);
  // export concealed_weapons := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'ffid', OPT);
end;