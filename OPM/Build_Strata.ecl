IMPORT tools, strata;

EXPORT Build_Strata(
	 STRING													pversion
	,BOOLEAN											  pOverwrite				= FALSE
	,DATASET(Layouts.base)	        pbase_fileFile   	= OPM.Files().base.built		
	,STRING												  pfileversion			= 'using'
	,BOOLEAN												pUseOtherEnviron	= OPM._Constants().isdataland
	,DATASET(Layouts.Sprayed_Input) pSprayedFile      = OPM.Files(pfileversion,pUseOtherEnviron).Input.logical
	,BOOLEAN											  pIsTesting				= tools._Constants.IsDataland
) := FUNCTION

	dUpdate := OPM.Strata_stats(pbase_fileFile,pfileversion,pUseOtherEnviron,pSprayedFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dInputNoGrouping					,OPM._Constants().Name	,'Input' 			,pversion	,OPM.email_notification_lists().buildsuccess	,BuildInputNoGrouping_Strata					,'View'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueInputNoGrouping		,OPM._Constants().Name	,'Input' 			,pversion	,OPM.email_notification_lists().buildsuccess	,BuildInputUniqueNoGrouping_Strata		,'View'				,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping								,OPM._Constants().Name	,'Base_file'  ,pversion	,OPM.email_notification_lists().buildsuccess	,BuildNoGrouping_Strata								,'View'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dCleanAddressState				,OPM._Constants().Name	,'Base_file'  ,pversion	,OPM.email_notification_lists().buildsuccess	,BuildCleanAddressState_Strata				,'Clean_State','Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueNoGrouping					,OPM._Constants().Name	,'Base_file'  ,pversion	,OPM.email_notification_lists().buildsuccess	,BuildUniqueNoGrouping_Strata					,'View'				,'Uniques'		,,pIsTesting,pOverwrite);
	
	full_build := PARALLEL(BuildInputNoGrouping_Strata			
												 ,BuildInputUniqueNoGrouping_Strata
												 ,BuildNoGrouping_Strata								
												 ,BuildCleanAddressState_Strata				
												 ,BuildUniqueNoGrouping_Strata
													);

	RETURN IF(tools.fun_IsValidVersion(pversion)
		       ,full_build		
		       ,OUTPUT('No Valid version parameter passed, skipping OPM.Build_Strata attribute'));
		
END;