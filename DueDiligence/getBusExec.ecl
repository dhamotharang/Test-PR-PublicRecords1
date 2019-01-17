IMPORT BIPV2, Business_Risk_BIP, DueDiligence;


EXPORT getBusExec(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
										Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
										BIPV2.mod_sources.iParams linkingOptions) := FUNCTION


    //get all execs - both with and without DIDs
    addExecs := DueDiligence.getSharedBEOs(indata, options, linkingOptions);
	
		//calculate the residency for each BEO
    getExecResidency := DueDiligence.getBusExecResidency(addExecs, options);	

	
	// OUTPUT(addExecs, NAMED('addExecs'));
	// OUTPUT(getExecResidency, NAMED('getExecResidency'));
	
	
	RETURN getExecResidency;
END;