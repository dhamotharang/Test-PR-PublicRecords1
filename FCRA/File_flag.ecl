import ut;


EXPORT File_flag := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::flag',FCRA.Layout_Override_Flag_In,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt)(flag_file_id not in FCRA.Suppress_Flag_File_ID),record_id,-(integer)flag_file_id),
except flag_file_id,override_flag,riskwise_uid,
  user_added,
date_added,
known_missing,
user_changed,
date_changed,
//DF-26286
name_suffix,
mname,keep(1))(trim(override_flag,left,right) = '1'); //DF-28345 Flag file suppression removed 10/22
//DF-26286