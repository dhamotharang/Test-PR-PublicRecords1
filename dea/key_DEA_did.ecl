import doxie,dea, data_services;

df := dea.File_DEA((integer)did != 0);

// export Key_DEA_did := index(df,{unsigned6 my_did :=(integer)did},{df},'~thor_data400::key::dea_did_' + doxie.Version_SuperKey);
export Key_DEA_did := index(df,
                            {unsigned6 my_did :=(integer)did},
                            {df},
                            data_services.data_location.prefix() + 'thor_data400::key::dea::' + doxie.Version_SuperKey + '::did');