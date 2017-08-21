import ut;

kf := dedup(sort(dataset(ut.foreign_prod+'thor_data400::base::override::fcra::qa::vehiclesv2_party',Layout_Override_VehiclesV2_Party,flat),-flag_file_id),except flag_file_id,keep(1));

export Key_Override_VehiclesV2_Party_FFID := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::vehiclesv2_party::qa::ffid');