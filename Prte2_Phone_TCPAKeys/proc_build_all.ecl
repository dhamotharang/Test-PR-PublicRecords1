EXPORT proc_build_all(string filedate) := FUNCTION

	build_keys   :=	proc_build_keys(filedate);
	orbit_build  := build_orbit(filedate);
	
	return_val := 	sequential(	build_keys, orbit_build) ;

	return return_val;
	
	end;