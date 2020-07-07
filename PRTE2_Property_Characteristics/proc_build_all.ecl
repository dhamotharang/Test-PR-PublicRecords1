
EXPORT proc_build_all (string filedate, boolean skipTest=FALSE, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	#workunit('name','PRTE PROPERTY CHARACTERISTICS BUILD');

	run_all := SEQUENTIAL(fSpray,	proc_build_keys(filedate), skipDops, 	emailTo	);
	
RETURN run_all;

END;