import tools,strata;
export Build_strata(
	 string															pversion
	,boolean														pOverwrite				= false
	,dataset(Layouts.Base_new						)	pBaseFile   			= Files().Base.built		
	,boolean														pIsTesting				= tools._Constants.IsDataland
) :=
function
	
	dUpdate := Strata_stats(pBaseFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping					,_Constants().Name	,'base'	,pversion	,email_notification_lists().buildsuccess	,BuildNoGrouping_Strata					,'NoGrouping'	,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dCleanAddressState	,_Constants().Name	,'base'	,pversion	,email_notification_lists().buildsuccess	,BuildCleanAddressState_Strata	,'Clean_State','Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dRecordType					,_Constants().Name	,'base'	,pversion	,email_notification_lists().buildsuccess	,BuildRecordType_Strata					,'Record_Type','Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniquesNoGrouping	,_Constants().Name	,'base'	,pversion	,email_notification_lists().buildsuccess	,BuildUniquesNoGrouping_Strata	,'NoGrouping'	,'Uniques'		,,pIsTesting,pOverwrite);

	full_build := 
	parallel(
		 BuildNoGrouping_Strata							
		,BuildCleanAddressState_Strata			
		,BuildRecordType_Strata					
		,BuildUniquesNoGrouping_Strata		
	);
	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping SalesChannel.proc_build_strata attribute')
	);
		
end;