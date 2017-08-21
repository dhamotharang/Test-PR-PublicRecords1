import ut;

kf := dedup(sort(dataset(ut.foreign_prod+'thor_data400::base::override::fcra::qa::vehiclesv2_main',Layout_Override_VehiclesV2_Main,flat),-flag_file_id),except flag_file_id,keep(1));

export Key_Override_VehiclesV2_Main_FFID := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::vehiclesv2_main::qa::ffid');


