IMPORT Business_Risk_BIP, DueDiligence;


EXPORT getBusExec(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
                  Business_Risk_BIP.LIB_Business_Shell_LIBIN options) := FUNCTION



  //calculate the residency for each BEO
  getExecResidency := DueDiligence.getBusExecResidency(indata, options);



  // OUTPUT(getExecResidency, NAMED('getExecResidency'));


  RETURN getExecResidency;
END;
