IMPORT fcra, ut, Email_Data; 

base_file0 := dataset('~thor_data400::base::override::fcra::qa::email_data',FCRA.Layout_Override_Email_Data_In,csv(separator('\t'),quote('\"'),terminator('\r\n')));
base_file  := PROJECT(base_file0,FCRA.Layout_Override_Email_Data);

kf := dedup(sort(base_file,-flag_file_id),except flag_file_id,keep(1));

//DF-22458 blank out selected field in thor_data400::key::override::fcra::email_data::qa::ffid
ut.MAC_CLEAR_FIELDS(kf, kf_cleared, Email_Data.Constants().fields_to_clear);

EXPORT Key_Override_Email_Data_ffid := index(kf_cleared,{flag_file_id}, {kf_cleared},
  '~thor_data400::key::override::fcra::Email_Data::qa::ffid');