IMPORT STD;

EXPORT fn_Validate_eCrashSuppBase() := FUNCTION
  supbase := Files_eCrash.DS_BASE_SUPPLEMENTAL;
  ebase := Files_eCrash.DS_BASE_ECRASH;

  //father base files
  supbase_father := Files_eCrash.DS_BASE_SUPPLEMENTAL_FATHER;
  ebase_father := Files_eCrash.DS_BASE_ECRASH_FATHER;


  ecr_threshold := 1000000;
  supp_threshold := 500000;

  BOOLEAN ecrash_check := COUNT(ebase) - COUNT(ebase_father) BETWEEN 1000 AND  ecr_threshold;
  BOOLEAN supp_check := COUNT(supbase) - COUNT(supbase_father) BETWEEN 50 AND supp_threshold;

  ds := nothor(STD.System.Workunit.WorkunitMessages(WORKUNIT));
  sndchk := IF(COUNT(ds ( message = 'Definition is sandboxed' AND REGEXFIND('FLAccidents_Ecrash',location) = TRUE)) > 0 ,FAIL('ECrash code has been sandbox'),  OUTPUT('ECrash code has not been commented'))  ;          

  countchk := IF(ecrash_check AND supp_check, OUTPUT('ECrash Base Build looks good'), SEQUENTIAL( FAIL('ECRASH KEY BUILD SHOULD BE ON HOLD'),
  STD.System.Email.SendEmail('sudhir.kasavajjala@lexisnexis.com',
													   'ECRASH KEY BUILD IS ON HOLD',
													   'eCrash Key build is on hold as base files were not updated')
  		                       ));


  RETURN SEQUENTIAL(sndchk, countchk );		
END;
