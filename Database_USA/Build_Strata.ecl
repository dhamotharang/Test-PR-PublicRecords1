IMPORT tools, strata;

EXPORT Build_Strata(
	 STRING													pversion
	,BOOLEAN											  pOverwrite				= FALSE
	,DATASET(Layouts.Base)	        pBaseFile   			= Database_USA.Files().Base.built		
	,STRING												  pfileversion			= 'using'
	,BOOLEAN												pUseOtherEnviron	= Database_USA._Constants().isdataland
	,DATASET(Layouts.Sprayed_Input) pSprayedFile      = Database_USA.Files(pfileversion,pUseOtherEnviron).Input.logical
	,BOOLEAN											  pIsTesting				= tools._Constants.IsDataland
) := FUNCTION

	dUpdate := Database_USA.Strata_stats(pBaseFile,pfileversion,pUseOtherEnviron,pSprayedFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dInputNoGrouping					,Database_USA._Constants().Name	,'Input'	   ,pversion	,Database_USA.email_notification_lists().buildsuccess	,BuildInputNoGrouping_Strata					,'View'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueInputNoGrouping		,Database_USA._Constants().Name	,'Input'	   ,pversion	,Database_USA.email_notification_lists().buildsuccess	,BuildInputUniqueNoGrouping_Strata		,'View'				,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping								,Database_USA._Constants().Name	,'base_file' ,pversion	,Database_USA.email_notification_lists().buildsuccess	,BuildNoGrouping_Strata								,'View'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dCleanAddressState				,Database_USA._Constants().Name	,'base_file' ,pversion	,Database_USA.email_notification_lists().buildsuccess	,BuildCleanAddressState_Strata				,'Clean_State','Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueNoGrouping					,Database_USA._Constants().Name	,'base_file' ,pversion	,Database_USA.email_notification_lists().buildsuccess	,BuildUniqueNoGrouping_Strata					,'View'				,'Uniques'		,,pIsTesting,pOverwrite);

	full_build := PARALLEL(
		 BuildInputNoGrouping_Strata			
		,BuildInputUniqueNoGrouping_Strata
		,BuildNoGrouping_Strata								
		,BuildCleanAddressState_Strata				
		,BuildUniqueNoGrouping_Strata);

	RETURN IF(tools.fun_IsValidVersion(pversion)
		       ,full_build		
		       ,OUTPUT('No Valid version parameter passed, skipping Database_USA.Build_Strata attribute'));
		
END;