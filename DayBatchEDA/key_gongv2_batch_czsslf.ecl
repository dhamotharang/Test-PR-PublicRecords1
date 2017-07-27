import gong, gong_v2, doxie;

f_gong_in := project(Gong_v2.proc_roxie_keybuild_prep_current(trim(p_city_name) <> ''), 
                     transform(gong_v2.Layout_bscurrent_raw, self:=left, self := []));

export key_gongv2_batch_czsslf :=	
   	index(f_gong_in,
				 {p_city_name,
				  z5,
					prim_name,
				  prim_range,				  
					name_last,
					name_first},
				 {f_gong_in},
				 Gong_v2.thor_cluster +'key::gongv2_czsslf_'+ doxie.Version_SuperKey
		);
