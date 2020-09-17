Import fcra, data_services, vault, _control;

#IF(_Control.Environment.onVault)
EXPORT Key_Override_Student_New_FFID := vault.FCRA.Key_Override_Student_New_FFID;
#ELSE
EXPORT Key_Override_Student_New_FFID := FUNCTION

  // Any record definitions can be exported, if needed
  ds_in_type := 'american_student_new';
  ds_type := 'student_new';
  fname_prefix := '~thor_data400::base::override::fcra::qa::';
  daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  keyname_prefix := data_services.data_location.prefix()+
                    'thor_data400::key::override::fcra::'+ds_type+'::qa::';

   ds_layout_old := RECORD
       fcra.Layout_Override_Student_New_In AND NOT tier2;
   END;

  //The existing base file does not contain tier2 key
  ds_old  := dataset(fname_prefix + ds_in_type, ds_layout_old, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),OPT);
  ds_base	:= project(ds_old, TRANSFORM(fcra.Layout_Override_Student_New_In,SELF.tier2:=' ',SELF:=LEFT));
  dailyds_old := dataset (daily_prefix + ds_in_type, ds_layout_old, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),OPT);
  dailyds := project(dailyds_old, TRANSFORM(fcra.Layout_Override_Student_New_In,SELF.tier2:=' ',SELF:=LEFT));
  kf := dedup (sort (ds_base, -flag_file_id), except flag_file_id);
  FCRA.Mac_Replace_Records(kf, dailyds, KEY, replaceds);

  fcra.layout_override_student_new proj_recs(fcra.Layout_Override_Student_New_In l) := transform
    self.key := (integer8)l.key;
    self.did := (unsigned6)l.did;
    self := l;
    self := [];
  end;

  ds_proj_recs := project(replaceds, proj_recs(left) );

  asl_ffid := index(ds_proj_recs, {flag_file_id}, {ds_proj_recs}, keyname_prefix + 'ffid', OPT);

  RETURN asl_ffid;

END;

#END;
