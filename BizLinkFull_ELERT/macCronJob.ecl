EXPORT macCronJob(iRunMode) := FUNCTIONMACRO
 
  IMPORT wk_ut AS pkgWorkUnit;
  IMPORT STD AS pkgSTD;

  sCronPrefix                       := '~thor::bizlinkfull::elert::cron_wus::';
  sVersion                          := StringLib.StringFilterOut(pkgSTD.Date.SecondsToString(pkgSTD.Date.CurrentSeconds(TRUE), '%F%I%M%S%u'), '-')[1..14];
  sRerunID                          := StringLib.StringFilterOut(pkgSTD.Date.SecondsToString(pkgSTD.Date.CurrentSeconds(TRUE), '%F%I%M%S%u'), '-')[1..14];
  sPrimaryQueue                     := BizLinkFull_ELERT.modConstants.sHthorQueue;
  sSecondaryQueue                   := BizLinkFull_ELERT.modConstants.sHthorQueue;
  sPollingFreq                      := BizLinkFull_ELERT.modConstants.sPollingFreq;  // how often to check on job status
  sEmailTo                          := BizLinkFull_ELERT.modConstants.sEmailNotify;  // these e-mail addresses will receive all process notifications
  sWuPrefix                         := BizLinkFull_ELERT.modFilenames(sCronPrefix).sPrefixMasterWUOutput;   // prefix for individual WORKUNIT output file
  sWuSuperfile                      := BizLinkFull_ELERT.modFilenames(sCronPrefix).kMasterWUOutput_SF.current; // general data on each WORKUNIT output into a logical file under this superfile
  bOutECL                           := BizLinkFull_ELERT.modConstants.bOutECL;

  dDebugInput1 := ''; // EMPTY == THORPROD

  sRunELERT_Text          := 'Monthly_BizLinkFull_ELERT_Run';
 
  sRunELERT_ECL           := map(iRunMode = 1 => 'BizLinkFull_ELERT.defaultAllSourcesRunCron.runJob;',
                                 iRunMode = 2 => 'BizLinkFull_ELERT.defaultVarietyStatsRunCron.runJob;',
                                 'NO MODE');
                                       
  assert(sRunELERT_ECL != 'NO MODE', 'NO MODE PROVIDED!!!', FAIL);

  aRunELERT               := pkgWorkUnit.mac_ChainWuids(sRunELERT_ECL, 1, 1, sVersion,, sPrimaryQueue, pOutputEcl := bOutECL,
                                      pUniqueOutput := sRunELERT_Text,
                                      pNotifyEmails := sEmailTo,
                                      pPollingFrequency := sPollingFreq,
                                      pOutputFilename := sWuPrefix + '@version@' + sRerunID + '::WUInfo_' + sRunELERT_Text,
                                      pOutputSuperfile := sWuSuperfile,
                                      pInDebug := dDebugInput1);
                                      

 
  RETURN  aRunELERT;
 
ENDMACRO;