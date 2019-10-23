EXPORT proc_dproptx_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	rundPropTx := InsuranceHeader.proc_dproptx(version_use).run;
	
	RETURN SEQUENTIAL(rundPropTx);
	
END;