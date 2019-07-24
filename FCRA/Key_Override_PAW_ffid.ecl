﻿import fcra, data_services, vault, _control;

base_file := dataset('~thor_data400::base::override::fcra::qa::PAW',FCRA.Layout_Override_PAW,flat);

kf := dedup(sort(base_file,-flag_file_id),except flag_file_id,keep(1));

#IF(_Control.Environment.onVault) 
export Key_Override_PAW_ffid := vault.FCRA.Key_Override_PAW_ffid;
#ELSE
export Key_Override_PAW_ffid := index(kf,
                                      {flag_file_id}, 
                                      {kf},
                                      data_services.data_location.prefix() + 'thor_data400::key::override::fcra::PAW::qa::ffid');
#END;																			