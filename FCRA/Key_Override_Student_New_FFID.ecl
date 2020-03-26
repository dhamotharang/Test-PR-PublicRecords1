Import Data_Services, fcra, ut, data_services, American_Student_List;

EXPORT Key_Override_Student_New_FFID := FUNCTION

	// Any record definitions can be exported, if needed
	ds_in_type := 'american_student_new';
	ds_type := 'student_new';
	fname_prefix := '~thor_data400::base::override::fcra::qa::';
	daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
	keyname_prefix := data_services.data_location.prefix('fcra_overrides')+
	                  'thor_data400::key::override::fcra::'+ds_type+'::qa::';

	// DF-23067 - Add tier2 field to override ASL input data file
 	ds_layout_old := RECORD
   		fcra.Layout_Override_Student_New;
 	END;
		
	//The existing base file does not contain tier2 key
  ds_base  := dataset(fname_prefix + ds_in_type, ds_layout_old, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),OPT);
	dailyds := dataset (daily_prefix + ds_in_type, ds_layout_old, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),OPT);
  kf := dedup (sort (ds_base, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf, dailyds, KEY, replaceds);
	
  fcra.layout_override_student_new proj_recs(fcra.Layout_Override_Student_New l) := transform
   	self.key := (integer8)l.key;
   	self.did := (unsigned6)l.did;
   	self := l;
  end;
  ds_proj_recs := project(replaceds, proj_recs(left) );

	//DF-2458 blank out specified fields in thor_data400::key::override::fcra::student::qa::ffid
	ut.MAC_CLEAR_FIELDS(ds_proj_recs, ds_proj_recs_cleared, American_Student_List.Constants.fields_to_clear);
	
	asl_ffid := index(ds_proj_recs_cleared, {flag_file_id}, {ds_proj_recs_cleared}, keyname_prefix + 'ffid', OPT);
	
	RETURN asl_ffid;
	
END;