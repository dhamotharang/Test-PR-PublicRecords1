EXPORT proc_ciidphone_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	runCiidphone := InsuranceHeader.proc_ciidphone(version_use).run;
	
	RETURN SEQUENTIAL(runCiidphone);
	
END;