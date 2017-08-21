import tools,strata;

export Build_Strata(

	 string									pversion
	,boolean								pOverwrite	= false
	,dataset(Layouts.Base	)	pBaseFile   = Files().Base.built		
	,boolean								pIsTesting	= false

) :=
module

	shared dUpdate := Strata_stats(pBaseFile);

	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping										,_Dataset().Name, 'baseV1', pversion, email_notification_lists.buildsuccess, BuildGeneric_Strata						,'View'							,'Population'	,true,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dDefendantaddressState				,_Dataset().Name, 'baseV1', pversion, email_notification_lists.buildsuccess, BuildDefendantSt_Strata				,'Defendant_State'	,'Population'	,true,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dAttorneyaddressState					,_Dataset().Name, 'baseV1', pversion, email_notification_lists.buildsuccess, BuildAttorneySt_Strata					,'Attorney_State'		,'Population'	,true,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueNoGrouping							,_Dataset().Name, 'baseV1', pversion, email_notification_lists.buildsuccess, BuildUniqueGeneric_Strata			,'View'							,'Uniques'		,true,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueDefendantaddressState	,_Dataset().Name, 'baseV1', pversion, email_notification_lists.buildsuccess, BuildUniqueDefendantSt_Strata	,'Defendant_State'	,'Uniques'		,true,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueAttorneyaddressState		,_Dataset().Name, 'baseV1', pversion, email_notification_lists.buildsuccess, BuildUniqueAttorneySt_Strata		,'Attorney_State'		,'Uniques'		,true,pIsTesting,pOverwrite);

	export all_stats := 
	if(tools.fun_IsValidVersion(pversion)
		,parallel(
			 BuildGeneric_Strata						
			,BuildDefendantSt_Strata				
			,BuildAttorneySt_Strata					
			,BuildUniqueGeneric_Strata			
			,BuildUniqueDefendantSt_Strata	
			,BuildUniqueAttorneySt_Strata		
		)
		,output('No Valid version parameter passed, skipping Garnishments.Build_Strata attribute')
	);
		
end;