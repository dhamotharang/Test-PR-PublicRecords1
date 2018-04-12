IMPORT tools, strata;

EXPORT Build_Strata(
	 STRING															pversion
	,BOOLEAN														pOverwrite				= FALSE
	,DATASET(Layouts.Base)	            pBaseFile   			= QA_Data.Files().Base.built		
	,STRING															pfileversion			= 'using'
	,BOOLEAN														pUseOtherEnviron	= QA_Data._Constants().isdataland
	,DATASET(QA_Data.Layouts.Input.Sprayed_Addresses)
	                                    pSprayedAddrFile  = QA_Data.Files(pfileversion,pUseOtherEnviron).Input_Addr.logical
	,DATASET(QA_Data.Layouts.Input.Sprayed_Transactions)
	                                    pSprayedTransFile = QA_Data.Files(pfileversion,pUseOtherEnviron).Input_Trans.logical
	,BOOLEAN														pIsTesting				= tools._Constants.IsDataland
) := FUNCTION

	dUpdate := QA_Data.Strata_stats(pBaseFile,pfileversion,pUseOtherEnviron,pSprayedAddrFile,pSprayedTransFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dAddrInputNoGrouping					,QA_Data._Constants().Name	,'Input_addr'	 ,pversion	,QA_Data.email_notification_lists().buildsuccess	,BuildAddrInputNoGrouping_Strata					,'View'							,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueAddrInputNoGrouping		,QA_Data._Constants().Name	,'Input_addr'	 ,pversion	,QA_Data.email_notification_lists().buildsuccess	,BuildAddrInputUniqueNoGrouping_Strata		,'View'							,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dTransInputNoGrouping					,QA_Data._Constants().Name	,'Input_trans' ,pversion	,QA_Data.email_notification_lists().buildsuccess	,BuildTransInputNoGrouping_Strata					,'View'							,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueTransInputNoGrouping		,QA_Data._Constants().Name	,'Input_trans' ,pversion	,QA_Data.email_notification_lists().buildsuccess	,BuildTransInputUniqueNoGrouping_Strata		,'View'							,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping								    ,QA_Data._Constants().Name	,'base_file'	 ,pversion	,QA_Data.email_notification_lists().buildsuccess	,BuildNoGrouping_Strata								    ,'View'							,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dCleanAddressState				    ,QA_Data._Constants().Name	,'base_file'	 ,pversion	,QA_Data.email_notification_lists().buildsuccess	,BuildCleanAddressState_Strata				    ,'Addr_address.st'	,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueNoGrouping					    ,QA_Data._Constants().Name	,'base_file'	 ,pversion	,QA_Data.email_notification_lists().buildsuccess	,BuildUniqueNoGrouping_Strata					    ,'View'							,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueCleanAddressState	    ,QA_Data._Constants().Name	,'base_file'	 ,pversion	,QA_Data.email_notification_lists().buildsuccess	,BuildUniqueCleanAddressState_Strata	    ,'Addr_address.st'	,'Uniques'		,,pIsTesting,pOverwrite);

	full_build := PARALLEL(
		 BuildAddrInputNoGrouping_Strata			
		,BuildAddrInputUniqueNoGrouping_Strata
		,BuildTransInputNoGrouping_Strata
		,BuildTransInputUniqueNoGrouping_Strata
		,BuildNoGrouping_Strata								
		,BuildCleanAddressState_Strata				
		,BuildUniqueNoGrouping_Strata					
		,BuildUniqueCleanAddressState_Strata);

	RETURN IF(tools.fun_IsValidVersion(pversion)
		       ,full_build		
		       ,OUTPUT('No Valid version parameter passed, skipping QA_Data.Build_Strata attribute'));
		
END;