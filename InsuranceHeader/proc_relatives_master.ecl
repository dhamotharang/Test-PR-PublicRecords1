EXPORT proc_relatives_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	runRelatives := InsuranceHeader.proc_relatives(version_use).run;
	
	RETURN SEQUENTIAL(runRelatives);
	
END;