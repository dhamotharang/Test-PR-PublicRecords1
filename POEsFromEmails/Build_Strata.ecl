import tools,strata;

export Build_Strata(

	 string															pversion
	,boolean														pOverwrite				= false
	,boolean														pUseOtherEnviron	= tools._Constants.IsDataland
	,dataset(Layouts.Base							)	pBaseFile   			= Files(,pUseOtherEnviron).Base.built		
	,boolean														pIsTesting				= tools._Constants.IsDataland

) :=
function

	dUpdate := Strata_stats(pUseOtherEnviron,pBaseFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping					,_Dataset().Name	,'base'		,pversion	,email_notification_lists.buildsuccess	,BuildNoGrouping_Strata				,'View'						,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.demail_src					,_Dataset().Name	,'base'		,pversion	,email_notification_lists.buildsuccess	,BuildEmail_Src_Strata				,'email_src'			,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dPerson_addr_st			,_Dataset().Name	,'base'		,pversion	,email_notification_lists.buildsuccess	,BuildPersonSt_Strata					,'Person_State'		,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dbh_Company_addr_st	,_Dataset().Name	,'base'		,pversion	,email_notification_lists.buildsuccess	,BuildCompanySt_Strata				,'Company_State'	,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueNoGrouping		,_Dataset().Name	,'base'		,pversion	,email_notification_lists.buildsuccess	,BuildUniqueNoGrouping_Strata	,'View'						,'Uniques'		,,pIsTesting,pOverwrite);

	full_build := 
	parallel(
		 BuildNoGrouping_Strata				
		,BuildEmail_Src_Strata				
		,BuildPersonSt_Strata					
		,BuildCompanySt_Strata				
		,BuildUniqueNoGrouping_Strata	
	);

	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping POEsFromEmails.Build_Strata attribute')
	);

end;