import fcra, data_services;

EXPORT key_Override_Alloy_FFID := FUNCTION

	// Any record definitions can be exported, if needed
	ds_type := 'alloy';
	fname_prefix := '~thor_data400::base::override::fcra::qa::';
	daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
	keyname_prefix := data_services.data_location.prefix() + 'thor_data400::key::override::fcra::'+ds_type+'::qa::';

 	ds_layout_old := RECORD
   		fcra.layout_override_alloy AND NOT tier2;
 	END;
		
	//The base file does not contain tier2 key
  ds_old  := dataset(fname_prefix + ds_type, ds_layout_old, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),OPT);
	ds_base	:= project(ds_old, TRANSFORM(fcra.layout_override_alloy,SELF.tier2:=' ',SELF:=LEFT));
	dailyds_old := dataset (daily_prefix + ds_type, ds_layout_old, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),OPT);
	dailyds := project(dailyds_old, TRANSFORM(fcra.layout_override_alloy,SELF.tier2:=' ',SELF:=LEFT));
  kf := dedup (sort (ds_base, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf, dailyds, DID, replaceds);
	alloy_ffid := index(replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'ffid', OPT);
	
	RETURN alloy_ffid;
	
END;

// ds_override := dataset('~thor_data400::base::override::fcra::qa::alloy', fcra.layout_override_alloy, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
// ds := dedup(sort(ds_override,-flag_file_id),except flag_file_id,keep(1));

// export Key_Override_Alloy_FFID := index(ds, {flag_file_id}, {ds}, 
// data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::alloy::qa::ffid');