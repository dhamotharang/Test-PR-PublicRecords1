import tools,strata;

export Build_Strata(

	 string															pversion
	,boolean														pOverwrite				= false
	,dataset(Layouts.Base							)	pBaseFile   			= Files().Base.built		
	,string															pfileversion			= 'using'
	,boolean														pUseOtherEnviron	= _Constants().isdataland
	,dataset(Layouts.Input.Sprayed		)	pSprayedFile			= Files(pfileversion,pUseOtherEnviron).Input.logical
	,boolean														pIsTesting				= tools._Constants.IsDataland

) :=
function

	dUpdate := Strata_stats(pBaseFile,pfileversion,pUseOtherEnviron,pSprayedFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dInputNoGrouping					,_Constants().Name	,'Input'	,pversion	,email_notification_lists().buildsuccess	,BuildInputNoGrouping_Strata					,'View'					,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueInputNoGrouping		,_Constants().Name	,'Input'	,pversion	,email_notification_lists().buildsuccess	,BuildInputUniqueNoGrouping_Strata		,'View'					,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping								,_Constants().Name	,'baseV2'	,pversion	,email_notification_lists().buildsuccess	,BuildNoGrouping_Strata								,'View'					,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dCleanAddressState				,_Constants().Name	,'baseV2'	,pversion	,email_notification_lists().buildsuccess	,BuildCleanAddressState_Strata				,'Clean_State'	,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueNoGrouping					,_Constants().Name	,'baseV2'	,pversion	,email_notification_lists().buildsuccess	,BuildUniqueNoGrouping_Strata					,'View'					,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueCleanAddressState	,_Constants().Name	,'baseV2'	,pversion	,email_notification_lists().buildsuccess	,BuildUniqueCleanAddressState_Strata	,'Clean_State'	,'Uniques'		,,pIsTesting,pOverwrite);
  
	full_build := 
	parallel(
		 BuildInputNoGrouping_Strata			
		,BuildInputUniqueNoGrouping_Strata
		,BuildNoGrouping_Strata								
		,BuildCleanAddressState_Strata				
		,BuildUniqueNoGrouping_Strata					
		,BuildUniqueCleanAddressState_Strata	
	);

	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping Credit_Unions.Build_Strata attribute')
	);
		
end;