import gong, doxie, data_Services; 

export key_did := index(gong.File_Gong_Did(did<>0),
                             {unsigned6 l_did := did},{gong.File_Gong_Did},
                             data_services.data_location.prefix() + 'thor_data400::key::gong_did_'+doxie.Version_SuperKey);
