export MAC_GHI_MatchCode(l_rec,r_rec) := MACRO
	
		MAP((ut.NBEQ(l_rec.name_last,r_rec.name_last) and
		ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
		ut.NBEQ(l_rec.z5,r_rec.z5) and						
		ut.NBEQ(l_rec.name_first,r_rec.name_first)) => 'G',													
		(ut.NBEQ(l_rec.name_last,r_rec.name_last) and
		ut.NBEQ(l_rec.p_city_name,r_rec.p_city_name) and
		ut.NBEQ(l_rec.z5,r_rec.z5) and						
		ut.NBEQ(l_rec.name_first_init,r_rec.name_first[1])) => 'H',
    'I')
	
	ENDMACRO;