import gong, doxie; 

export key_hhid := index(gong.file_gong_hhid(hhid<>0),
                             {unsigned6 s_hhid := hhid},{gong.file_gong_hhid},
                             '~thor_data400::key::gong_hhid_'+doxie.Version_SuperKey);
	
	