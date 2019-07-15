
EXPORT proc_build_all(string filedate) := FUNCTION
	#workunit('name','PRTE FBN BUILD');
	
	return_val := sequential(fSpray, proc_build_base(filedate),proc_build_keys(filedate));

	return return_val;

END;