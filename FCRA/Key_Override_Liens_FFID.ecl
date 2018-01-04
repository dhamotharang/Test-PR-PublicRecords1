import data_services;

//kf := dataset('~thor_data400::in::fcra::override::evictions_20060818',fcra.Layout_override_Liens,flat)(rmsid <> '');
//TODO: add proper filtering
kf := dataset('~thor_data400::base::override::fcra::qa::liens',fcra.Layout_override_Liens,flat);

export key_override_liens_ffid := index(kf,
                                        {flag_file_id}, 
                                        {kf},
                                        data_services.data_location.prefix() + 'thor_data400::key::override::fcra::liens::qa::ffid');