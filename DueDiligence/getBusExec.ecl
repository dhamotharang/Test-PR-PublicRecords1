IMPORT BIPV2, Business_Risk_BIP, DueDiligence, Doxie;


EXPORT getBusExec(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
										Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
										BIPV2.mod_sources.iParams linkingOptions,
                                        doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION


    //get all execs - both with and without DIDs
    addExecs := DueDiligence.getSharedBEOs(indata, options, linkingOptions, mod_access);
	
		//calculate the residency for each BEO
    getExecResidency := DueDiligence.getBusExecResidency(addExecs, options, mod_access);	

	
	// OUTPUT(addExecs, NAMED('addExecs'));
	// OUTPUT(getExecResidency, NAMED('getExecResidency'));
	
	
	RETURN getExecResidency;
END;