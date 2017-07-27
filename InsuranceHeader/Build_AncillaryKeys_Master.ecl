
EXPORT Build_AncillaryKeys_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	
	RETURN InsuranceHeader.Build_AncillaryKeys(version_use);
	
END;
