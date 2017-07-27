import gong, doxie; 

gong_did_add_base := gong.file_gong_did_add(did<>0);

export key_did_add := index(gong_did_add_base,
                              {unsigned6 l_did := did},{gong_did_add_base},
                              '~thor_data400::key::gong_did_add_'+doxie.Version_SuperKey, OPT);
