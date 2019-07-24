/*******************************************************************************************************************
 Spray 20 test seed data files onto THOR from CargoDayton /data/testseed_prod/filedate
********************************************************************************************************************/
IMPORT Versioncontrol, _Control, tools, STD;


EXPORT spray_DueDiligencePersonReport(STRING filedate,
                                      BOOLEAN pIsTesting = FALSE,
                                      STRING pServer = _Control.IPAddress.CargoDayton,
                                      STRING pDir = '/data/testseed_prod/'+filedate+'/',
                                      STRING pGroupName = STD.System.Thorlib.Group()) := FUNCTION


  SHARED baseFileLocation := '~thor_data400::base::dueDiligencePersonReport_testseed_';


	setupSuperFiles(STRING keyname) := FUNCTION

		sfile := baseFileLocation + keyname;
		RETURN SEQUENTIAL(
							FileServices.StartSuperFileTransaction(),
							IF(FileServices.FileExists(sfile),FileServices.ClearSuperFile(sfile,true),FileServices.CreateSuperFile(sfile)),
							FileServices.FinishSuperFileTransaction()
							);
	END;
	
  flfile(STRING pkeyword) := '~thor_data400::in::testseed::' + filedate + '::duediligencepersonreport::' + pkeyword;
  fsfile(STRING pkeyword) := baseFileLocation + pkeyword;
	
	spry_raw:=DATASET([
		 {pServer,pDir,'DueDiligencePersonReport_testseeds_BestInfo.csv'							,0 ,flfile('BestInfo'			),[{fsfile('BestInfo'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_PersonInfo.csv' 					  ,0 ,flfile('PersonInfo'				),[{fsfile('PersonInfo'				)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_Attributes.csv' 						,0 ,flfile('Attributes'				),[{fsfile('Attributes'				)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_Legal.csv' 							  ,0 ,flfile('Legal'				),[{fsfile('Legal'				)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_EconomicIncome.csv' 			  ,0 ,flfile('EconomicIncome'			),[{fsfile('EconomicIncome'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_EconomicProperty.csv' 			,0 ,flfile('EconomicProperty'			),[{fsfile('EconomicProperty'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_EconomicVehicle.csv' 			,0 ,flfile('EconomicVehicle'		),[{fsfile('EconomicVehicle'		)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_EconomicWatercraft.csv' 		,0 ,flfile('EconomicWatercraft'			),[{fsfile('EconomicWatercraft'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_EconomicAircraft.csv' 			,0 ,flfile('EconomicAircraft'			),[{fsfile('EconomicAircraft'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_ProfessionalNetwork.csv' 	,0 ,flfile('ProfessionalNetwork'	),[{fsfile('ProfessionalNetwork'	)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_BusinessAssociation.csv' 	,0 ,flfile('BusinessAssociation'		),[{fsfile('BusinessAssociation'		)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'DueDiligencePersonReport_testseeds_IdentityAge.csv' 				  ,0 ,flfile('IdentityAge'		),[{fsfile('IdentityAge'		)}],pGroupName,filedate,'','VARIABLE'}
	], VersionControl.Layout_Sprays.Info);
		
		RETURN SEQUENTIAL( 
				setupSuperFiles('BestInfo'),
				setupSuperFiles('PersonInfo'),
				setupSuperFiles('Attributes'),
				setupSuperFiles('Legal'),
				setupSuperFiles('EconomicIncome'),
				setupSuperFiles('EconomicProperty'),
				setupSuperFiles('EconomicVehicle'),
				setupSuperFiles('EconomicWatercraft'),
				setupSuperFiles('EconomicAircraft'),
				setupSuperFiles('ProfessionalNetwork'),
				setupSuperFiles('BusinessAssociation'),
				setupSuperFiles('IdentityAge'),
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
							'DueDiligencePersonReportTestSeed ' + filedate,			// pEmailSubjectDataset
							'DueDiligencePersonReportTestSeed Spray Info', 			// pOutputName
							FALSE, 																	// pShouldClearSuperfileFirst
							FALSE, 																	// pSplitEmails
							FALSE, 																	// pShouldSprayZeroByteFiles
							FALSE																		// pShouldSprayMultipleFilesAs1
						));

	
END;