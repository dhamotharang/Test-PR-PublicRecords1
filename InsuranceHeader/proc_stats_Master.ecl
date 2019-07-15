EXPORT proc_stats_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	runStats := InsuranceHeader.proc_stats(version_use).run;
	
	RETURN SEQUENTIAL(runStats);
	
END;