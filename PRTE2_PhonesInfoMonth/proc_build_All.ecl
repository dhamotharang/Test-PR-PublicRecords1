﻿EXPORT proc_build_all(string filedate) := FUNCTION

	build_base_file	:=	proc_build_base(filedate);

	build_keys :=	proc_build_keys(filedate);
	
	orbit_build:= build_orbit(filedate);
	
	return_val := 	sequential(	build_base_file, build_keys, orbit_build) ;

	return return_val;

END;