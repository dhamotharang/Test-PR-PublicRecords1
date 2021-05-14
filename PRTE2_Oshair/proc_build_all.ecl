IMPORT PRTE2_Oshair;

EXPORT proc_build_all(string filedate) := FUNCTION

	build_base_file	:=	PRTE2_Oshair.proc_build_base(filedate);

	build_keys :=	PRTE2_Oshair.proc_build_keys(filedate);
	
	build_orbit_function :=	PRTE2_Oshair.build_orbit(filedate);
	
	
	return_val := 	sequential(	build_base_file, build_keys, build_orbit_function ) ;
	

	return return_val;

END;