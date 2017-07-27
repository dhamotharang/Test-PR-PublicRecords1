import fcra, ut;

kf := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::watercraft',fcra.layout_override_watercraft,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

export key_override_watercraft_ffid := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::watercraft::qa::ffid');