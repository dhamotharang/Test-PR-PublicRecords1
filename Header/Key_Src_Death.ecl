Import Data_Services, header,data_services;

dDeath_as_Source	:=	header.Files_SeqdSrc().DE;

mac_key_src(dDeath_as_Source, header.Layout_Did_Death_MasterV2 - [state_death_flag,death_rec_src], 
						death_child, 
						data_services.data_location.prefix('Source')+'thor_data400::key::death_src_index_',id)
						
export Key_Src_Death := id;