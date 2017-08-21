// 2/6/17, added parameters to pass into proc_build_liens_keys, defaults make them optional

EXPORT proc_build_all (string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

	run_all := SEQUENTIAL(proc_build_base, proc_build_liens_keys(filedate,skipDOPS,emailTo));
	
RETURN run_all;
END;