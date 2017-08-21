Import Data_Services, dea, data_services;

dDEA_as_Source	:=	header.Files_SeqdSrc().DEA;

mac_key_src(dDEA_as_Source, DEA.layout_DEA_In, 
						dea_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::dea_src_index_',id)
						
export Key_Src_DEA := id;