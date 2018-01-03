import  doxie, data_services;

df := file_proflicense_keybuilt((integer)bdid != 0);

export key_proflic_bdid := index(df,
                                 {unsigned6 bd := (integer)df.bdid},{df},
                                 data_services.data_location.prefix() + 'thor_data400::key::proflic_bdid_' + doxie.Version_SuperKey);