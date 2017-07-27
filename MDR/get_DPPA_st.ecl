import header, ut;

export get_DPPA_st(string2 src, string2 st) := 
	if(src = 'MA', 
	   if(ut.valid_st(st), st, 'XX'),						//just return addr st for mixed records
	   (string2)header.translateSource(src));