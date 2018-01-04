import doxie, data_services;

export key_fdids := index(file_cwp_with_fdid,{fdid},{file_cwp_with_fdid},
                          data_services.data_location.prefix() + 'thor_data400::key::canadianwp_fdids_' + doxie.Version_SuperKey);
