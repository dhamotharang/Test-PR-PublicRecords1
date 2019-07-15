EXPORT proc_addrHier_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	runAddrHier := InsuranceHeader.proc_addrHier(version_use).run;
	
	RETURN SEQUENTIAL(runAddrHier);
	
END;