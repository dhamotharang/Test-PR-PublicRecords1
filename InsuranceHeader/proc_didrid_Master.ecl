EXPORT proc_didrid_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	runDidRid := InsuranceHeader.proc_RidDidFile(version_use).run;
	
	RETURN SEQUENTIAL(runDidRid);
	
END;