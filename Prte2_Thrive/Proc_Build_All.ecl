EXPORT proc_build_all(STRING version) := FUNCTION
	#workunit('name','PRTE Thrive Base and Key Build');
	
	          return_val := sequential(fnSpray, Proc_build_base(version), proc_build_keys(version));

	RETURN return_val;

END;