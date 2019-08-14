import gong, doxie, data_services;
f := PROJECT(gong.File_Gong_full(trim(name_last) <> ''), gong.Layout_bscurrent_raw);
export key_gong_batch_lczf := 	
	index(f,
				 {name_last,
					p_city_name,
				  z5,
					name_first},
				 {f},
				 data_services.data_location.prefix() + 'thor_data400::key::gong_lczf_'+ doxie.Version_SuperKey
	);