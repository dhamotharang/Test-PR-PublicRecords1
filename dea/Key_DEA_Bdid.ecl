import doxie, data_services;

df := dea.File_DEA((integer)bdid != 0);

// export Key_DEA_Bdid := index(df,{unsigned6 bd := (integer)bdid},{df},'~thor_data400::key::dea_bdid_' + doxie.Version_SuperKey);
export Key_DEA_Bdid := index(df,
                             {unsigned6 bd := (integer)bdid},
                             {df},
                             data_services.data_location.prefix() + 'thor_data400::key::dea::' + doxie.Version_SuperKey + '::bdid');
