EXPORT proc_salt_master(STRING version) := FUNCTION
	
		version_use := version + '_' + WORKUNIT;
		runSalt := 	InsuranceHeader.proc_salt(version_use).runIter;
		
		RETURN SEQUENTIAL(runSalt);

END;