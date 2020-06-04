EXPORT proc_build_all (string filedate, boolean skipTest=FALSE, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
#workunit('name', 'PRTE SBFE Build - ' + filedate);

	run_all := SEQUENTIAL(
													fSpray 
													,parallel(proc_build_base(filedate)/*, proc_build_base_sbfe_bip_best(filedate)*/) 
													,proc_build_keys(filedate)
													,skipDops
													,emailTo
												);
	
RETURN run_all;
END;



