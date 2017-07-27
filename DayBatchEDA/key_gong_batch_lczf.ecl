import gong, doxie;
export key_gong_batch_lczf := 	
	index(gong.File_Gong_full(trim(name_last) <> ''),
				 {name_last,
					p_city_name,
				  z5,
					name_first},
				 {gong.File_Gong_full},
				 '~thor_data400::key::gong_lczf_'+ doxie.Version_SuperKey
	);