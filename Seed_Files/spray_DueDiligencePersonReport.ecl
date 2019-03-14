/*******************************************************************************************************************
 Spray 20 test seed data files onto THOR from bctlpedata12 /data/hds_2/duediligence_report_test_seed/filedate
********************************************************************************************************************/
IMPORT Versioncontrol, _Control, tools, STD;


EXPORT spray_DueDiligencePersonReport(string filedate,
                                      boolean	pIsTesting	= false,
                                      string		pServer			= _Control.IPAddress.bctlpedata12,
                                      string		pDir				= '/data/hds_2/duediligence_report_test_seed/'+filedate+'/',
                                      string 	pGroupName 	= STD.System.Thorlib.Group()) := FUNCTION

	setupSuperFiles(STRING keyname) := FUNCTION

		sfile := '~thor_data400::base::dueDiligencePersonReport_testseed_' + keyname;
		RETURN SEQUENTIAL(
							FileServices.StartSuperFileTransaction(),
							IF(FileServices.FileExists(sfile),FileServices.ClearSuperFile(sfile,true),FileServices.CreateSuperFile(sfile)),
							FileServices.FinishSuperFileTransaction()
							);
	END;
	
	flfile(string pkeyword) := '~thor_data400::in::testseed::' + filedate + '::duediligencepersonreport::' + pkeyword;
  fsfile(string pkeyword) := '~thor_data400::base::dueDiligencePersonReport_testseed_' + pkeyword;
	
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