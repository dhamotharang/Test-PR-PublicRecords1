import gong,doxie, data_services;

export key_gong_add_batch_czsslf :=	
   	index(gong.File_Daily_Full(trim(p_city_name) <> ''),
				 {p_city_name,
				  z5,
					prim_name,
				  prim_range,				  
					name_last,
					name_first},
				 {gong.File_Daily_Full},
				 data_services.data_location.prefix() + 'thor_data400::key::gong_czsslf_add_'+ doxie.Version_SuperKey,OPT
		);