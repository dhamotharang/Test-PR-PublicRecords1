IMPORT STD;

EXPORT fn_Validate_CRUBase (STRING filedate)  := FUNCTION
  crubase := Files_eCrash.DS_BASE_CONSOLIDATION_CRU;

  //father base files
  crubase_father := Files_eCrash.DS_BASE_CONSOLIDATION_CRU_FATHER;

  cru_threshold := 1000000;
  BOOLEAN ecrashcru_check := COUNT(crubase) - COUNT(crubase_father) BETWEEN 1000 AND  cru_threshold;
 
  string_rec := RECORD
   STRING10	processdate;
  END;
 
  despray_trigger	:= SEQUENTIAL(
                                OUTPUT(DATASET([{filedate}],string_rec),,'~thor_data400::out::ecrash_spversion', OVERWRITE),
                                STD.File.DeSpray('~thor_data400::out::ecrash_spversion',Constants.LandingZone,
                                                 '/data/super_credit/ecrash/alphabuild/despray/ecrashflag_'+ filedate + '_' + Std.Date.CurrentTime(TRUE)+'.txt',
																  							 ,,,TRUE)
                               );

  countchk := IF ( ecrashcru_check   ,SEQUENTIAL( OUTPUT('ECrash CRU Base Build looks good'), despray_trigger) , 
  STD.System.Email.SendEmail('sudhir.kasavajjala@lexisnexis.com; DataDevelopment-InsRiskeCrash@lexisnexisrisk.com',
                            'ECRASH CRU KEY BUILD IS ON HOLD --' + filedate,
                            'eCrash cru Key build is on hold as base file counts dropped')
                            );
  RETURN countchk;
END;
