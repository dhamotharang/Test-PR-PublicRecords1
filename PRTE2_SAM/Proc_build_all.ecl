EXPORT proc_build_all(STRING version) := FUNCTION
	#workunit('name','PRTE Sam BUILD');
	
	return_val := sequential(fnSpray, Proc_build_base, proc_build_keys(version));

	RETURN return_val;

END;