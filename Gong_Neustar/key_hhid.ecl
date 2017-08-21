Import Data_Services, doxie, ut; 

export key_hhid := index(file_gong_hhid(hhid<>0),
                             {unsigned6 s_hhid := hhid},{file_gong_hhid},
                             Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::key::gong_hhid_'+doxie.Version_SuperKey);
	
	