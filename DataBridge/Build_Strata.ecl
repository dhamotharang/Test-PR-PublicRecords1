IMPORT tools, strata;

EXPORT Build_Strata(
	 STRING													pversion
	,BOOLEAN											  pOverwrite				= FALSE
	,DATASET(Layouts.Base)	        pBaseFile   			= DataBridge.Files().Base.built		
	,STRING												  pfileversion			= 'using'
	,BOOLEAN												pUseOtherEnviron	= DataBridge._Constants().isdataland
	,DATASET(Layouts.Sprayed_Input) pSprayedFile      = DataBridge.Files(pfileversion,pUseOtherEnviron).Input.logical
	,BOOLEAN											  pIsTesting				= tools._Constants.IsDataland
) := FUNCTION

	dUpdate := DataBridge.Strata_stats(pBaseFile,pfileversion,pUseOtherEnviron,pSprayedFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dInputNoGrouping					,DataBridge._Constants().Name	,'Input'	   ,pversion	,DataBridge.email_notification_lists().buildsuccess	,BuildInputNoGrouping_Strata					,'View'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueInputNoGrouping		,DataBridge._Constants().Name	,'Input'	   ,pversion	,DataBridge.email_notification_lists().buildsuccess	,BuildInputUniqueNoGrouping_Strata		,'View'				,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping								,DataBridge._Constants().Name	,'base_file' ,pversion	,DataBridge.email_notification_lists().buildsuccess	,BuildNoGrouping_Strata								,'View'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dCleanAddressState				,DataBridge._Constants().Name	,'base_file' ,pversion	,DataBridge.email_notification_lists().buildsuccess	,BuildCleanAddressState_Strata				,'Clean_State','Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueNoGrouping					,DataBridge._Constants().Name	,'base_file' ,pversion	,DataBridge.email_notification_lists().buildsuccess	,BuildUniqueNoGrouping_Strata					,'View'				,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueCleanAddressState	,DataBridge._Constants().Name	,'base_file' ,pversion	,DataBridge.email_notification_lists().buildsuccess	,BuildUniqueCleanAddressState_Strata	,'Clean_State','Uniques'		,,pIsTesting,pOverwrite);

	full_build := PARALLEL(
		 BuildInputNoGrouping_Strata			
		,BuildInputUniqueNoGrouping_Strata
		,BuildNoGrouping_Strata								
		,BuildCleanAddressState_Strata				
		,BuildUniqueNoGrouping_Strata					
		,BuildUniqueCleanAddressState_Strata);

	RETURN IF(tools.fun_IsValidVersion(pversion)
		       ,full_build		
		       ,OUTPUT('No Valid version parameter passed, skipping DataBridge.Build_Strata attribute'));
		
END;