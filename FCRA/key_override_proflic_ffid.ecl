import fcra, data_services;

kf := dataset('~thor_data400::base::override::fcra::qa::proflic',fcra.layout_override_proflic,flat);

export key_override_proflic_ffid := index(kf,
                                          {flag_file_id}, 
                                          {kf},
                                          data_services.data_location.prefix() + 'thor_data400::key::override::fcra::proflic::qa::ffid');