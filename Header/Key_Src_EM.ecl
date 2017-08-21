Import Data_Services, emerges,data_services;

dMaster_as_Source	:=	header.Files_SeqdSrc().EM;

mac_key_src(dMaster_as_Source, emerges.layout_emerge_in, 
						emerge_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::em_src_index_',id)
						
export Key_Src_EM := id;