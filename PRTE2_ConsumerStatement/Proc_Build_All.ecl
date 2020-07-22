EXPORT proc_build_all(STRING version) := FUNCTION
	#workunit('name','PRTE ConsumerStatement Base and Key Build');
	
	return_val := sequential(fSpray, Proc_build_base, proc_build_keys(version));

	RETURN return_val;

END;