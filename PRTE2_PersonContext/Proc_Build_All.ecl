
EXPORT proc_build_all (string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

	run_all := SEQUENTIAL(fspray, proc_build_base, proc_build_keys(filedate,skipDOPS,emailTo));
	
RETURN run_all;
END;