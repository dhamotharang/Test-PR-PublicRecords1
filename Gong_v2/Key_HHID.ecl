import gong, gong_v2, doxie; 

f_gong_hhid := dedup(sort(Gong_v2.File_Gong_HHID,record),record);


export key_hhid := index(f_gong_hhid(hhid<>0),
                         {unsigned6 s_hhid := hhid},{f_gong_hhid},
                         Gong_v2.thor_cluster+'key::gongv2_hhid_'+doxie.Version_SuperKey);
	
	