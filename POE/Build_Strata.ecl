import tools,strata;

export Build_Strata(

	 string									pversion
	,boolean								pOverwrite	= false
	,dataset(Layouts.Base	)	pBaseFile   = Files().Base.built		
	,boolean								pIsTesting	= _Dataset().IsDataland

) :=
module

	shared dUpdate := Strata_Stats(pBaseFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping		,_Dataset().Name, 'base', pversion, email_notification_lists.buildsuccess, BuildGeneric_Strata		,'View'										,'Population',,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dSubjectState	,_Dataset().Name, 'base', pversion, email_notification_lists.buildsuccess, BuildSubjectSt_Strata	,'Subject_Address_State'	,'Population',,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dSource				,_Dataset().Name, 'base', pversion, email_notification_lists.buildsuccess, BuildSource_Strata			,'Source'									,'Population',,pIsTesting,pOverwrite);

	full_build := 
	parallel(
		 BuildGeneric_Strata		
		,BuildSubjectSt_Strata	
		,BuildSource_Strata			
	);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping POE.Build_Strata attribute')
	);
		
end;