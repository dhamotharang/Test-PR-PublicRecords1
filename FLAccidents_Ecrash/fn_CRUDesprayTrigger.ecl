IMPORT STD;

EXPORT fn_CRUDesprayTrigger(STRING filedate) := FUNCTION

  DesprayTriggerFile := STD.File.DeSpray(Constants.CruDesprayThorFileName,
																         Constants.LandingZone,
                                         Constants.CruDesprayFilePath + 'ecrashflag_' + filedate + '_' + mod_Utilities.SysTime + '.txt',
                                         ,
																				 ,
																				 ,
																				 TRUE);

  CRUDesprayTrigger	:= SEQUENTIAL(
                                  OUTPUT(DATASET([{filedate}], {STRING10	processdate}),, Constants.CruDesprayThorFileName, OVERWRITE)
                                  ,DesprayTriggerFile
                                 );
																 
 RETURN CRUDesprayTrigger;
 
END;
