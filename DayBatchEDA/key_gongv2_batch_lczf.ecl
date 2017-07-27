import gong, gong_v2, doxie;

f_gong_in := project(Gong_v2.proc_roxie_keybuild_prep_current(trim(name_last) <> '' and (current_record_flag='Y')), 
                     transform(gong_v2.Layout_bscurrent_raw, self:=left, self := []));

export key_gongv2_batch_lczf := 	
	index(f_gong_in,
				 {name_last,
					p_city_name,
				  z5,
					name_first},
				 {f_gong_in},
				 Gong_v2.thor_cluster+'key::gongv2_lczf_'+ doxie.Version_SuperKey
	);