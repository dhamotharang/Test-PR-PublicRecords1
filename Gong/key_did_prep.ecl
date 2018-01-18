import gong, data_services; 

export key_did_prep := index(gong.File_Gong_Did(did<>0, trim(phone10)<>''),
                             {unsigned6 l_did := did},{gong.File_Gong_Did},
                             data_services.data_location.prefix() + 'thor_data400::key::gong_did' + thorlib.wuid());