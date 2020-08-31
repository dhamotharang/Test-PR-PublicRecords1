import fcra, ut;

//CCPA-1048
base_file0 := dataset('~thor_data400::base::override::fcra::qa::Inquiries',FCRA.Layout_Override_Inquiries_In,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
base_file  := PROJECT(base_file0,FCRA.Layout_Override_Inquiries);

//DF-28168 - filter out records with blank flag_file_id
kf := dedup(sort(base_file(flag_file_id<>''),-flag_file_id),except flag_file_id,keep(1));

export Key_Override_Inquiries_ffid := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::Inquiries::qa::ffid');