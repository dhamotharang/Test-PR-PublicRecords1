IMPORT data_services, vault, _control;

kf := FCRA.Convert_Liens_Party_Func;

#IF(_Control.Environment.onVault) 
EXPORT key_Override_liensv2_party_ffid := vault.FCRA.key_Override_liensv2_party_ffid;
#ELSE
EXPORT key_Override_liensv2_party_ffid := index (kf, 
                                                 {flag_file_id}, 
                                                 {kf},
                                                 data_services.data_location.prefix() + 'thor_data400::key::override::fcra::liensV2_party::qa::ffid', OPT);
#END;

