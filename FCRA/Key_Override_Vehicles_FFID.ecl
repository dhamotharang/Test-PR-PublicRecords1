import fcra, ut;

kf := dataset('~thor_data400::base::override::fcra::qa::vehicles',fcra.layout_override_vehicles,flat);

export key_override_vehicles_ffid := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::vehicles::qa::ffid');