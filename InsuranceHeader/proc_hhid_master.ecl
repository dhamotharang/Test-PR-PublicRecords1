EXPORT proc_hhid_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	runHhid := InsuranceHeader.proc_hhid(version_use).run;
	
	RETURN SEQUENTIAL(runHhid);
	
END;