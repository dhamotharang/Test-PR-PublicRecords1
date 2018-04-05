EXPORT proc_build_all (string filedate) := FUNCTION

	run_all := SEQUENTIAL(fSpray,proc_build_base, proc_build_keys(filedate));
	
RETURN run_all;
END;