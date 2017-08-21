Import Data_Services, GovData, data_services;

dMS_Worker_as_Source	:=	header.Files_SeqdSrc().WC;

mac_key_src(dMS_Worker_as_Source, govdata.Layout_MS_Workers_Comp_In, 
						mswork_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::ms_src_index_',id)
						
export Key_Src_MS := id;