import data_services;

kf := dataset('~thor_data400::base::override::fcra::qa::liensv2',fcra.Layout_override_Liensv2,flat);

export Key_Override_LiensV2_FFID := index(kf,
                                          {flag_file_id}, 
                                          {kf},
                                          data_services.data_location.prefix() + 'thor_data400::key::override::fcra::liensV2::qa::ffid');