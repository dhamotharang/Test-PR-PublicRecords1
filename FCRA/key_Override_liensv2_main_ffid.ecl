IMPORT data_services, vault, _control;

kf := fcra.Convert_Liens_Main_Func;

#IF(_Control.Environment.onVault) 
EXPORT key_Override_liensv2_main_ffid := vault.FCRA.key_Override_liensv2_main_ffid;
#ELSE
EXPORT key_Override_liensv2_main_ffid := index (kf, 
                                                {flag_file_id}, 
                                                {kf},
                                                data_services.data_location.prefix() + 'thor_data400::key::override::fcra::liensV2_main::qa::ffid', OPT);
#END;
