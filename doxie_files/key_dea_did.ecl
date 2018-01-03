import dea,doxie, data_services;

export key_dea_did := index(dea.File_DEA_Doxie,
                            {unsigned6 my_did := (integer)dea.File_Dea_Doxie.did},
                            {dea.File_Dea_Doxie},
                            data_services.data_location.prefix() + 'thor_data400::key::dea_did_' + doxie.Version_SuperKey);