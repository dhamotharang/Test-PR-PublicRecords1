EXPORT proc_build_all (string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

	run_all := SEQUENTIAL(fSpray,proc_build_base, proc_build_keys(filedate, skipDops, emailTo));
	
RETURN run_all;
END;