EXPORT proc_build_all(string filedate) := FUNCTION

	build_keys :=	proc_build_keys(filedate);
	
	return_val := 	build_keys;
	
	return_orbit :=build_orbit(filedate);

	return return_val;

END;