import gong, gong_v2, doxie; 

f_gong_did := Gong_v2.proc_roxie_keybuild_prep_current;

export key_did := index(f_gong_did(did<>0),
                        {unsigned6 l_did := did},{f_gong_did},
                         gong_v2.thor_cluster+'key::gongv2_did_'+doxie.Version_SuperKey);
