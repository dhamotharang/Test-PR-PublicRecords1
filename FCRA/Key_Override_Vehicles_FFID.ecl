import fcra, data_services;

kf := dataset('~thor_data400::base::override::fcra::qa::vehicles',fcra.layout_override_vehicles,flat);

export key_override_vehicles_ffid := index(kf,
                                           {flag_file_id}, 
                                           {kf},
                                           data_services.data_location.prefix() + 'thor_data400::key::override::fcra::vehicles::qa::ffid');