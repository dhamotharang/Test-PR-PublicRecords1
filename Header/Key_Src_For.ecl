Import Data_Services, property,data_services;

dForeclosure_as_Source	:=	header.Files_SeqdSrc().FR;

mac_key_src(dForeclosure_as_Source, Property.Layout_Fares_Foreclosure_for_Keys, 
						for_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::for_src_index_',id)
						
export Key_Src_For := id;