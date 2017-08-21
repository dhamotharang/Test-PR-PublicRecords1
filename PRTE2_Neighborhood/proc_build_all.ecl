EXPORT proc_build_all (string filedate) := FUNCTION

	run_all := proc_build_keys(filedate); //Currently no need for a base build as this is only metadata
	
RETURN run_all;
END;