import tools,strata;

export Build_Strata(

	 string															pversion
	,boolean														pOverwrite				= false
	,dataset(Layouts.Base							)	pBaseFile   			= Files().Base.built		
	,boolean														pIsTesting				= tools._Constants.IsDataland

) :=
function

	dUpdate := Strata_Population_Stats(pBaseFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping								,_Constants().Name	,'dataV2'		,pversion	,email_notification_lists().buildsuccess	,BuildNoGrouping_Strata								,'View'					,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dCleanAddressState				,_Constants().Name	,'dataV2'		,pversion	,email_notification_lists().buildsuccess	,BuildCleanAddressState_Strata				,'Clean_State'	,'Population'	,,pIsTesting,pOverwrite);

	full_build := 
	parallel(
		 BuildNoGrouping_Strata								
		,BuildCleanAddressState_Strata				
	);

	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping Debt_Settlement.Build_Strata attribute')
	);
		
end;