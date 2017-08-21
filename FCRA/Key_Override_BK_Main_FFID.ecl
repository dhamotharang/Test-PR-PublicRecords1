import fcra, ut;

kf := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::bankrupt_main',FCRA.Layout_Override_bk_filing,flat),-flag_file_id),except flag_file_id, keep(1));

export key_override_bk_main_ffid := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::bankrupt_filing::qa::ffid');