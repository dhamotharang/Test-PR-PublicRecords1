import fcra, data_services, vault, _control;

kf := dataset('~thor_data400::base::override::fcra::qa::proflic',fcra.layout_override_proflic,flat);


#IF(_Control.Environment.onVault) 
export key_override_proflic_ffid := vault.FCRA.key_override_proflic_ffid;
#ELSE
export key_override_proflic_ffid := index(kf,
                                          {flag_file_id}, 
                                          {kf},
                                          data_services.data_location.prefix() + 'thor_data400::key::override::fcra::proflic::qa::ffid');
#END;


