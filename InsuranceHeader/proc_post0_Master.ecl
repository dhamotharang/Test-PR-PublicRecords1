EXPORT proc_post0_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	runpost0 := InsuranceHeader.proc_postprocess(version_use).run;
	
	RETURN SEQUENTIAL(runpost0);
END;