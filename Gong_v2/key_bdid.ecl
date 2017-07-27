import gong_v2, doxie; 

export key_bdid := index(gong_v2.File_Gong_BDID(bdid<>0),
                             {unsigned6 l_bdid := bdid},{gong_v2.File_Gong_BDID},
                             Gong_v2.thor_cluster+'key::gongv2_bdid_'+doxie.Version_SuperKey);