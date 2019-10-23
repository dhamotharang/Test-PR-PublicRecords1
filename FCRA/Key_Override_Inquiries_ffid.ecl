import fcra, ut;

base_file := dataset('~thor_data400::base::override::fcra::qa::Inquiries',FCRA.Layout_Override_Inquiries,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

kf := dedup(sort(base_file,-flag_file_id),except flag_file_id,keep(1));

export Key_Override_Inquiries_ffid := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::Inquiries::qa::ffid');