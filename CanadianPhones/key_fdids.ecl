import doxie;

export key_fdids := index(file_cwp_with_fdid,{fdid},{file_cwp_with_fdid},
                          '~thor_data400::key::canadianwp_fdids_' + doxie.Version_SuperKey);
