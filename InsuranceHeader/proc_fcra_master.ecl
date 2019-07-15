EXPORT proc_fcra_master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	runFCRA := InsuranceHeader.proc_fcra(version_use).run;
	
	RETURN SEQUENTIAL(runFCRA);
	
END;