/*******************************************************************************************************************
 Spray 20 test seed data files onto THOR from CargoDayton /data/testseed_prod/filedate
********************************************************************************************************************/
IMPORT _Control, STD, tools, Versioncontrol;


EXPORT spray_DueDiligenceBusinessReport(STRING filedate,
                                        BOOLEAN	pIsTesting = FALSE,
                                        STRING pServer = _Control.IPAddress.CargoDayton,
                                        STRING pDir = '/data/testseed_prod/'+filedate+'/',
                                        STRING pGroupName = STD.System.Thorlib.Group()) := FUNCTION
                                      
                                      
  SHARED baseFileLocation := '~thor_data400::base::dueDiligenceBusinessReport_testseed_';
                                      

	setupSuperFiles(STRING keyname) := FUNCTION

		sfile := baseFileLocation + keyname;
		RETURN SEQUENTIAL(
							FileServices.StartSuperFileTransaction(),
							IF(FileServices.FileExists(sfile),FileServices.ClearSuperFile(sfile,true),FileServices.CreateSuperFile(sfile)),
							FileServices.FinishSuperFileTransaction()
							);
	END;
  
  
  
  
	
  flfile(string pkeyword) := '~thor_data400::in::testseed::' + filedate + '::duediligencebusinessreport::' + pkeyword;
  fsfile(string pkeyword) := baseFileLocation + pkeyword;
	
	spry_raw:=DATASET([
		 {pServer, pDir, 'DueDiligenceBusinessReport_testseeds_InputEcho.csv', 0, flfile('InputEcho'), [{fsfile('InputEcho')}], pGroupName, filedate, '', 'VARIABLE'}
		,{pServer, pDir, 'DueDiligenceBusinessReport_testseeds_Attributes.csv', 0, flfile('Attributes'), [{fsfile('Attributes')}], pGroupName, filedate, '', 'VARIABLE'}
	], VersionControl.Layout_Sprays.Info);
	
	
  
		RETURN SEQUENTIAL( 
				setupSuperFiles('InputEcho'),
				setupSuperFiles('Attributes'),
				tools.fun_Spray
						( 
							spry_raw,																// pSprayInformation
							, 																			// pSprayInfoSuperfile
							,																				// pSprayInfoLogicalfile
							TRUE, 																	// pOverwrite
							,																				// pReplicate
							TRUE,																		// pAddCounter
							pIsTesting,															// pIsTesting
							,																				// pEmailNotificationList
							'DueDiligenceBusinessReportTestSeed ' + filedate,			// pEmailSubjectDataset
							'DueDiligenceBusinessReportTestSeed Spray Info', 			// pOutputName
							FALSE, 																	// pShouldClearSuperfileFirst
							FALSE, 																	// pSplitEmails
							FALSE, 																	// pShouldSprayZeroByteFiles
							FALSE																		// pShouldSprayMultipleFilesAs1
						));

	
END;