Import Data_Services, emerges,data_services;

dBoat_as_Source	:=	header.Files_SeqdSrc().BO;

mac_key_src(dBoat_as_Source, emerges.layout_boats_in, 
						boater_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::boater_src_index_',id)
						
export Key_Src_Boater := id;