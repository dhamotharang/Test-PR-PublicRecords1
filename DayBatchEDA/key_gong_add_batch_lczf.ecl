import gong,doxie;
export key_gong_add_batch_lczf := 
	index(gong.File_Daily_Full(trim(name_last) <> ''),
				 {name_last,
					p_city_name,
				  z5,
					name_first},
				 {gong.File_Daily_Full},
				 '~thor_data400::key::gong_lczf_add_'+ doxie.Version_SuperKey,OPT
	);