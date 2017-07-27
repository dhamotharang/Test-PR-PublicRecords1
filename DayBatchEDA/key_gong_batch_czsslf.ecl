import gong, doxie;
export key_gong_batch_czsslf :=	
   	index(gong.File_Gong_full(trim(p_city_name) <> ''),
				 {p_city_name,
				  z5,
					prim_name,
				  prim_range,				  
					name_last,
					name_first},
				 {gong.File_Gong_full},
				 '~thor_data400::key::gong_czsslf_'+ doxie.Version_SuperKey
		);
