import fcra, ut;

kf := dedup(sort(dataset(ut.foreign_prod+'thor_data400::base::override::fcra::qa::vehicles',fcra.layout_override_vehicles,flat),-flag_file_id),except flag_file_id,keep(1));

export key_override_vehicles_ffid := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::vehicles::qa::ffid');