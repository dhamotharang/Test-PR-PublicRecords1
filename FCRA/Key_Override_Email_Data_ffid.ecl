﻿import fcra, data_services, vault, _control;

base_file0 := dataset('~thor_data400::base::override::fcra::qa::email_data', FCRA.Layout_Override_Email_Data_In, flat);
base_file  := PROJECT(base_file0, FCRA.Layout_Override_Email_Data);

kf := dedup(sort(base_file,-flag_file_id),except flag_file_id,keep(1));

#IF(_Control.Environment.onVault)
export Key_Override_Email_Data_ffid := vault.FCRA.Key_Override_Email_Data_ffid;
#ELSE
export Key_Override_Email_Data_ffid := index(kf,
                                             {flag_file_id},
                                             {kf},
                                             data_services.data_location.prefix() + 'thor_data400::key::override::fcra::Email_Data::qa::ffid');

#END;
