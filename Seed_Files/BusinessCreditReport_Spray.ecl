/*******************************************************************************************************************
 Spray 20 test seed data files onto THOR from bctlpedata12 /data/hds_2/credit_report_test_seed/filedate
********************************************************************************************************************/
IMPORT Versioncontrol, _Control, tools, STD;
EXPORT BusinessCreditReport_Spray(
	 string		filedate
	,boolean	pIsTesting	= false
	,string		pServer			= _Control.IPAddress.bctlpedata12
	,string		pDir				= '/data/hds_2/credit_report_test_seed/'+filedate+'/' 
	,string 	pGroupName 	= STD.System.Thorlib.Group()
) :=
FUNCTION

	setupSuperFiles(STRING keyname) := FUNCTION

		sfile := '~thor_data400::base::testseed_'+keyname;
		RETURN SEQUENTIAL(
							FileServices.StartSuperFileTransaction(),
							IF(FileServices.FileExists(sfile),FileServices.ClearSuperFile(sfile,true),FileServices.CreateSuperFile(sfile)),
							FileServices.FinishSuperFileTransaction()
							);
	END;
	
	flfile(string pkeyword) := '~thor_data400::in::testseed::'+filedate+'::businesscreditreport::'+pkeyword;
  fsfile(string pkeyword) := '~thor_data400::base::testseed_'+pkeyword;
	
	spry_raw:=DATASET([
		 {pServer,pDir,'BusinessCreditReport_testseeds_1Echo.csv'									,0 ,flfile('inputecho'			),[{fsfile('inputecho'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_2BestInfo.csv' 					  ,0 ,flfile('bestinfo'				),[{fsfile('bestinfo'				)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_3Scoring.csv' 							,0 ,flfile('scoring'				),[{fsfile('scoring'				)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_4Summary.csv' 							,0 ,flfile('summary'				),[{fsfile('summary'				)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_5OwnerGuarantor.csv' 			,0 ,flfile('ownguartor'			),[{fsfile('ownguartor'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_6TopBusBans.csv' 					,0 ,flfile('bankruptcy'			),[{fsfile('bankruptcy'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_7TopBusLiens.csv' 					,0 ,flfile('topbusliens'		),[{fsfile('topbusliens'		)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_8TopBusUCC.csv' 						,0 ,flfile('topbusucc'			),[{fsfile('topbusucc'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_9TopBusProperty.csv' 			,0 ,flfile('topbusprop'			),[{fsfile('topbusprop'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_10TopBusMVehicle.csv' 			,0 ,flfile('topbusmvehicle'	),[{fsfile('topbusmvehicle'	)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_11TopBusWCraft.csv' 				,0 ,flfile('topbuswcraft'		),[{fsfile('topbuswcraft'		)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_12TopBusACraft.csv' 				,0 ,flfile('topbusacraft'		),[{fsfile('topbusacraft'		)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_13TopBusLicense.csv' 			,0 ,flfile('topbuslicense'	),[{fsfile('topbuslicense'	)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_14TopBusIncorporation.csv'	,0 ,flfile('topbusincorp'		),[{fsfile('topbusincorp'		)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_15TopBusOperations.csv' 		,0 ,flfile('topbusoper'			),[{fsfile('topbusoper'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_16TopBusParent.csv'			 	,0 ,flfile('topbusparent'		),[{fsfile('topbusparent'		)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_17TopBusConnectedBus.csv' 	,0 ,flfile('topbusconnect'	),[{fsfile('topbusconnect'	)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_18TopBusContacts.csv' 		 	,0 ,flfile('topbuscontacts'	),[{fsfile('topbuscontacts'	)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_19Activity.csv' 						,0 ,flfile('topbusactivity'	),[{fsfile('topbusactivity'	)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'BusinessCreditReport_testseeds_20CRMatch.csv' 						,0 ,flfile('crmatch'				),[{fsfile('crmatch'				)}],pGroupName,filedate,'','VARIABLE'}
	], VersionControl.Layout_Sprays.Info);
		
		RETURN SEQUENTIAL( 
				setupSuperFiles('inputecho'),
				setupSuperFiles('bestinfo'),
				setupSuperFiles('scoring'),
				setupSuperFiles('summary'),
				setupSuperFiles('ownguartor'),
				setupSuperFiles('bankruptcy'),
				setupSuperFiles('topbusliens'),
				setupSuperFiles('topbusucc'),
				setupSuperFiles('topbusprop'),
				setupSuperFiles('topbusmvehicle'),
				setupSuperFiles('topbuswcraft'),
				setupSuperFiles('topbusacraft'),
				setupSuperFiles('topbuslicense'),
				setupSuperFiles('topbusincorp'),
				setupSuperFiles('topbusoper'),
				setupSuperFiles('topbusparent'),
				setupSuperFiles('topbusconnect'),
				setupSuperFiles('topbuscontact'),
				setupSuperFiles('topbusactivity'),
				setupSuperFiles('crmatch'),
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
							'CreditReportTestSeed ' + filedate,			// pEmailSubjectDataset
							'CreditReportTestSeed Spray Info', 			// pOutputName
							FALSE, 																	// pShouldClearSuperfileFirst
							FALSE, 																	// pSplitEmails
							FALSE, 																	// pShouldSprayZeroByteFiles
							FALSE																		// pShouldSprayMultipleFilesAs1
						));

	
END;