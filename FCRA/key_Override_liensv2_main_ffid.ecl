IMPORT data_services;

kf := fcra.Convert_Liens_Main_Func;

EXPORT key_Override_liensv2_main_ffid := index (kf, 
                                                {flag_file_id}, 
                                                {kf},
                                                data_services.data_location.prefix() + 'thor_data400::key::override::fcra::liensV2_main::qa::ffid', OPT);