import gong, doxie, data_services; 

export key_bdid := index(gong.File_BDID_Gong(bdid<>0),
                             {unsigned6 l_bdid := bdid},{gong.File_BDID_Gong},
                             data_services.data_location.prefix() + 'thor_data400::key::gong_bdid_'+doxie.Version_SuperKey);
