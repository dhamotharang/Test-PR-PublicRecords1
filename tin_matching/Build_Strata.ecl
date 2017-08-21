import tools,strata;
export Build_Strata(
	 string															pversion
	,boolean														pOverwrite			= false
	,dataset(Layouts.Input.Sprayed		)	pSprayedFile		= Files().input.prod_thor.using
	,dataset(layouts.base							)	pBaseFile				= files().base.prod_thor.built
	,boolean														pIsTesting			= true
) :=
function
	dUpdate := Strata_stats(pSprayedFile,pBaseFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dInputNoGrouping				,_Constants().Name	,'Input'	,pversion	,email_notification_lists().buildsuccess	,BuildInputNoGrouping_Strata				,'View'		,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniquesInputNoGrouping	,_Constants().Name	,'Input'	,pversion	,email_notification_lists().buildsuccess	,BuildUniqueInputNoGrouping_Strata	,'View'		,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dBaseNoGrouping					,_Constants().Name	,'Base'		,pversion	,email_notification_lists().buildsuccess	,BuildBaseNoGrouping_Strata					,'View'		,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniquesBaseNoGrouping	,_Constants().Name	,'Base'		,pversion	,email_notification_lists().buildsuccess	,BuildUniquesBaseNoGrouping_Strata	,'View'		,'Uniques'		,,pIsTesting,pOverwrite);
                                                                                                                                                                 
	full_build :=                                                                                                                                                  
	parallel(                                                                                                                                                      
		 BuildInputNoGrouping_Strata								
		,BuildUniqueInputNoGrouping_Strata					
		,BuildBaseNoGrouping_Strata										
		,BuildUniquesBaseNoGrouping_Strata						
	);
	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping tin_matching.Build_Strata attribute')
	);
		
end;
