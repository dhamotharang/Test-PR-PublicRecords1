import doxie, data_services;

export key_prep_dea_did := index(dea.File_DEA_Doxie((integer)did != 0),
                                 {unsigned6 my_did := (integer)dea.File_Dea_Doxie.did},
                                 {dea.File_Dea_Doxie},
                                 data_services.data_location.prefix() + 'thor_data400::key::dea_did' + thorlib.wuid());