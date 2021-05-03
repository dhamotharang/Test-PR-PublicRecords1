EXPORT proc_build_all(STRING version) := FUNCTION
	#workunit('name','PRTE Infutor_CID');
	
	return_val := sequential(Proc_build_base(version), proc_build_keys(version));

	RETURN return_val;

END;