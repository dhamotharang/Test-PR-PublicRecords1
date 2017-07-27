import gong; 

export key_did_prep := index(gong.File_Gong_Did(did<>0, trim(phone10)<>''),
                             {unsigned6 l_did := did},{gong.File_Gong_Did},
                             '~thor_data400::key::gong_did' + thorlib.wuid());