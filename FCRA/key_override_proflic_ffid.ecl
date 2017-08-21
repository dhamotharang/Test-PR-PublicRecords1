import fcra, ut;

kf := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::proflic',fcra.layout_override_proflic,csv(separator('\t'),quote('\"'),terminator('\r\n'))),-flag_file_id),except flag_file_id,keep(1));

export key_override_proflic_ffid := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::proflic::qa::ffid');