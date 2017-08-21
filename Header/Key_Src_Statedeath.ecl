Import Data_Services, Header,data_services;

dState_Death_as_Source	:=	header.Files_SeqdSrc().DS;

mac_key_src(dState_Death_as_Source, header.Layout_State_Death, 
						state_death_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::statedeath_src_index_',id)
						
export Key_Src_Statedeath := id;