Import Data_Services, Targus,data_services;
t_in := header.Files_SeqdSrc().WP;
mac_key_src(t_in, targus.layout_consumer_out, 
						targ_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::targ_src_index_',id)
						
export Key_Src_Targus := id;