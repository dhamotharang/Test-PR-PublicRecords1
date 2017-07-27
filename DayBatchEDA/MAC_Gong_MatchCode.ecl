export MAC_Gong_MatchCode(l_rec,r_rec) := MACRO  

	MAP((ut.NBEQ(l_rec.prim_name,r_rec.prim_name) and
			 ut.NBEQ(l_rec.prim_range,r_rec.prim_range) and
			 ut.NNEQ(l_rec.predir,r_rec.predir) and
			 ut.NNEQ(l_rec.suffix,r_rec.suffix) and
			 ut.NNEQ(l_rec.postdir,r_rec.postdir) and
			 ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5) and
			 ut.NBEQ(l_rec.name_last,r_rec.name_last) and
			 ut.NBEQ(l_rec.name_first,r_rec.name_first)) => 'A',
			 
			(ut.NBEQ(l_rec.prim_name,r_rec.prim_name) and
			 ut.NBEQ(l_rec.prim_range,r_rec.prim_range) and
			 ut.NNEQ(l_rec.predir,r_rec.predir) and
			 ut.NNEQ(l_rec.suffix,r_rec.suffix) and
			 ut.NNEQ(l_rec.postdir,r_rec.postdir) and
			 ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5) and
			 ut.NBEQ(l_rec.name_last,r_rec.name_last) and
			 ut.NBEQ(l_rec.name_first_init,r_rec.name_first[1])) => 'B',
			 
			(ut.NBEQ(l_rec.prim_name,r_rec.prim_name) and
			 ut.NBEQ(l_rec.prim_range,r_rec.prim_range) and
			 ut.NNEQ(l_rec.predir,r_rec.predir) and
			 ut.NNEQ(l_rec.suffix,r_rec.suffix) and
			 ut.NNEQ(l_rec.postdir,r_rec.postdir) and
			 ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5) and
			 ut.NBEQ(l_rec.name_last,r_rec.name_last)) => 'C',
	
			(ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5) and
			 ut.NBEQ(l_rec.prim_name,r_rec.prim_name) and
			 ut.NNEQ(l_rec.predir,r_rec.predir) and
			 ut.NNEQ(l_rec.suffix,r_rec.suffix) and
			 ut.NNEQ(l_rec.postdir,r_rec.postdir) and
			 ut.NBEQ(l_rec.name_last,r_rec.name_last) and
			 ut.NBEQ(l_rec.name_first,r_rec.name_first)) => 'D',
		
			(ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5) and
			 ut.NBEQ(l_rec.prim_name,r_rec.prim_name) and
			 ut.NNEQ(l_rec.predir,r_rec.predir) and
			 ut.NNEQ(l_rec.suffix,r_rec.suffix) and
			 ut.NNEQ(l_rec.postdir,r_rec.postdir) and
			 ut.NBEQ(l_rec.name_last,r_rec.name_last) and
			 ut.NBEQ(l_rec.name_first_init,r_rec.name_first[1])) => 'E',
		
			(ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5) and
			 ut.NBEQ(l_rec.prim_name,r_rec.prim_name) and
			 ut.NNEQ(l_rec.predir,r_rec.predir) and
			 ut.NNEQ(l_rec.suffix,r_rec.suffix) and
			 ut.NNEQ(l_rec.postdir,r_rec.postdir) and
			 ut.NBEQ(l_rec.name_last,r_rec.name_last)) => 'F',
		
			(ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5) and
			 ut.NBEQ(l_rec.prim_name,r_rec.prim_name) and
			 ut.NBEQ(l_rec.prim_range,r_rec.prim_range) and
			 ut.NNEQ(l_rec.predir,r_rec.predir) and
			 ut.NNEQ(l_rec.suffix,r_rec.suffix) and
			 ut.NNEQ(l_rec.postdir,r_rec.postdir)) => 'J',
		
			(ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5) and
			 ut.NBEQ(l_rec.prim_name,r_rec.prim_name)and
			 ut.NNEQ(l_rec.predir,r_rec.predir) and
			 ut.NNEQ(l_rec.suffix,r_rec.suffix) and
			 ut.NNEQ(l_rec.postdir,r_rec.postdir)) => 'K',
		
			(ut.NBEQ(l_rec.name_last,r_rec.name_last) and
			 ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5) and						
			 ut.NBEQ(l_rec.name_first,r_rec.name_first)) => 'G',
		
			(ut.NBEQ(l_rec.name_last,r_rec.name_last) and
			 ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5) and						
			 ut.NBEQ(l_rec.name_first_init,r_rec.name_first[1])) => 'H',
		
			(ut.NBEQ(l_rec.name_last,r_rec.name_last) and
			 ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5)) => 'I',
		
			(ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
			 ut.NBEQ(l_rec.z5,r_rec.z5)) => 'L',
			 
			(ut.NBEQ(l_rec.name_last,r_rec.name_last) and
			 ut.NBEQ(l_rec.name_first,r_rec.name_first)) => 'M',
		
			(ut.NBEQ(l_rec.name_last,r_rec.name_last) and
			 ut.NBEQ(l_rec.name_first_init,r_rec.name_first[1])) => 'N',
			 'O')
	
ENDMACRO;