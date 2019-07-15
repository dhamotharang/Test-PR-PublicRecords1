IMPORT IDL_Header;
EXPORT proc_Slender_Master(STRING version) := FUNCTION

	version_use := version + '_' + WORKUNIT;
	runSlender := InsuranceHeader.proc_slender(version_use).run;
	
	RETURN SEQUENTIAL(runSlender);
	
END;