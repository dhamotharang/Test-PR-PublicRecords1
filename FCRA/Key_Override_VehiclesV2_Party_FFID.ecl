import data_services;

kf := dataset('~thor_data400::base::override::fcra::qa::vehiclesv2_party',Layout_Override_VehiclesV2_Party,flat);

export Key_Override_VehiclesV2_Party_FFID := index(kf,
                                                   {flag_file_id}, 
                                                   {kf},
                                                   data_services.data_location.prefix() + 'thor_data400::key::override::fcra::vehiclesv2_party::qa::ffid');