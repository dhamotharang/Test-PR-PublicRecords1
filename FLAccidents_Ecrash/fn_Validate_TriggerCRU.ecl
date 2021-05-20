IMPORT STD;

EXPORT fn_Validate_TriggerCRU (STRING filedate) := FUNCTION

  CRUBaseCurrent := Files_eCrash.DS_BASE_CONSOLIDATION_CRU;
  CRUBasePrevious := Files_eCrash.DS_BASE_CONSOLIDATION_CRU_FATHER;

  ThresholdLimit := 1000000;
  BOOLEAN isCRUBaseValid := COUNT(CRUBaseCurrent) - COUNT(CRUBasePrevious) BETWEEN 1000 AND  ThresholdLimit;

  ValidateAndTriggerCRU := IF(isCRUBaseValid,
	                            SEQUENTIAL(OUTPUT('ECrash CRU Base Build looks good')
								                         ,fn_CRUDesprayTrigger(filedate)
													               ), 
                              STD.System.Email.SendEmail('sudhir.kasavajjala@lexisnexis.com; DataDevelopment-InsRiskeCrash@lexisnexisrisk.com',
                                                         'ECRASH CRU KEY BUILD IS ON HOLD --' + filedate,
                                                         'eCrash cru Key build is on hold as base file counts dropped')
                              );
													
	//Use below return to Only Trigger CRU Despray
  // RETURN fn_CRUDesprayTrigger(filedate);
	
	RETURN ValidateAndTriggerCRU;
END;
