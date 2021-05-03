EXPORT proc_build_all(STRING version) := FUNCTION
	#workunit('name','PRTE PhoneMart Base and Key Build');
	
	return_val := sequential(Proc_build_base, proc_build_keys(version));

	RETURN return_val;

END;
