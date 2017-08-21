import tools,strata;
export Build_Strata(
	 string													pversion
	,boolean												pOverwrite		= false
	,dataset(Layouts.Base					)	pBaseFile   	= Files().Base.built		
	,dataset(Layouts.Input.Sprayed)	pSprayedFile	= Files().Input.using
	,boolean												pIsTesting		= tools._Constants.IsDataland
) :=
function

	dUpdate := Strata_stats(pBaseFile,pSprayedFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dInputNoGrouping					,_Dataset().Name	,'Input'	,pversion	,email_notification_lists().buildsuccess	,BuildInputNoGrouping_Strata					,'View'					,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueInputNoGrouping		,_Dataset().Name	,'Input'	,pversion	,email_notification_lists().buildsuccess	,BuildInputUniqueNoGrouping_Strata		,'View'					,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping								,_Dataset().Name	,'base'		,pversion	,email_notification_lists().buildsuccess	,BuildNoGrouping_Strata								,'View'					,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dCleanAddressState				,_Dataset().Name	,'base'		,pversion	,email_notification_lists().buildsuccess	,BuildCleanAddressState_Strata				,'Clean_State'	,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueNoGrouping					,_Dataset().Name	,'base'		,pversion	,email_notification_lists().buildsuccess	,BuildUniqueNoGrouping_Strata					,'View'					,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueCleanAddressState	,_Dataset().Name	,'base'		,pversion	,email_notification_lists().buildsuccess	,BuildUniqueCleanAddressState_Strata	,'Clean_State'	,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dAppendDIDNoGrouping			,_Dataset().Name	,'PersistID',pversion	,email_notification_lists().buildsuccess	,BuildAppendDIDNoGrouping_Strata			,'View'					,'Population'	,,pIsTesting,pOverwrite);

	full_build := 
	parallel(
		 BuildInputNoGrouping_Strata			
		,BuildInputUniqueNoGrouping_Strata
		,BuildNoGrouping_Strata								
		,BuildCleanAddressState_Strata				
		,BuildUniqueNoGrouping_Strata					
		,BuildUniqueCleanAddressState_Strata	
		,BuildAppendDIDNoGrouping_Strata	
	);
	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping Judges.Build_Strata attribute')
	);
		
end;
