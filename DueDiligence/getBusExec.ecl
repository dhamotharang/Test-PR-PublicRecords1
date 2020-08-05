IMPORT BIPV2, Business_Risk_BIP, DueDiligence, Doxie;


EXPORT getBusExec(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
                  Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                  doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION



		//calculate the residency for each BEO
    getExecResidency := DueDiligence.getBusExecResidency(indata, options, mod_access);	

	
  
	// OUTPUT(getExecResidency, NAMED('getExecResidency'));
	
	
	RETURN getExecResidency;
END;