import fcra, ut;

kf := dataset('~thor_data400::base::override::fcra::qa::avm',fcra.layout_override_avm,flat);

export Key_Override_AVM_FFID := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::avm::qa::ffid');