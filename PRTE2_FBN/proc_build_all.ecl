
EXPORT proc_build_all(string filedate) := FUNCTION
	
	return_val := sequential(proc_build_base(filedate),proc_build_keys(filedate));

	return return_val;

END;