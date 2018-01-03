import doxie, data_services;

df := fbn.File_FBN(bdid != 0);

export key_fbn_bdid := index(df,{bdid},{df},
                             data_services.data_location.prefix() + 'thor_Data400::key::fbn_bdid_' + doxie.Version_SuperKey, OPT);