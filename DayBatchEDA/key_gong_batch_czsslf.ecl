import gong, doxie, data_services;
f := PROJECT(gong.File_Gong_full(trim(p_city_name) <> ''), gong.Layout_bscurrent_raw);
export key_gong_batch_czsslf :=	
   	index(f,
				 {p_city_name,
				  z5,
					prim_name,
				  prim_range,				  
					name_last,
					name_first},
				 {f},
				 data_services.data_location.prefix() + 'thor_data400::key::gong_czsslf_'+ doxie.Version_SuperKey
		);
