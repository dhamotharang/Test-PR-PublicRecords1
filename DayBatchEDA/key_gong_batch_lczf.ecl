import gong, doxie, data_services;

export key_gong_batch_lczf := 	
	index(gong.File_Gong_full(trim(name_last) <> ''),
				 {name_last,
					p_city_name,
				  z5,
					name_first},
				 {gong.File_Gong_full},
				 data_services.data_location.prefix() + 'thor_data400::key::gong_lczf_'+ doxie.Version_SuperKey
	);