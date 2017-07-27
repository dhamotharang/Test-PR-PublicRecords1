import gong, doxie; 

export key_bdid := index(gong.File_BDID_Gong(bdid<>0),
                             {unsigned6 l_bdid := bdid},{gong.File_BDID_Gong},
                             '~thor_data400::key::gong_bdid_'+doxie.Version_SuperKey);
