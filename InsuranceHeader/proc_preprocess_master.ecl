EXPORT proc_preprocess_master(STRING version) := FUNCTION
		
		version_use := version + '_' + WORKUNIT;
		runPreprocess := IFF(version[LENGTH(version)] <> '1',InsuranceHeader.proc_preprocess(version_use).runSuppress,InsuranceHeader.proc_preprocess(version_use).run);
		
		RETURN SEQUENTIAL(runPreprocess);

END;