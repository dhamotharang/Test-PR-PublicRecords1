import dea, data_services;

dDEA_as_Source	:=	dea.dea_as_source(,true);

mac_key_src(dDEA_as_Source, DEA.layout_DEA_In, 
						dea_child, 
						data_services.data_location.prefix() + 'thor_data400::key::dea_src_index_',id)
						
export Key_Src_DEA := id;