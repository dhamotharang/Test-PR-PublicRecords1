import data_services;

mac_key_src(govdata.MS_Worker_as_Source, govdata.Layout_MS_Workers_Comp_In, 
						mswork_child, 
						data_services.data_location.prefix() + 'thor_data400::key::ms_src_index_',id)
						
export Key_Src_MS := id;