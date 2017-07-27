Import Data_Services, FAA,data_services;

dAirmen_as_Source	:=	header.Files_SeqdSrc().AM;

mac_key_src(dAirmen_as_Source, faa.layout_airmen_data_out - source, 
						airm_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::airm_src_index_',id)
						
export Key_Src_Airm := id;