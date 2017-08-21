import tools,strata;

export Build_Strata(

	 string									pversion
	,boolean								pOverwrite	= false
	,dataset(Layouts.Base	)	pBaseFile   = Files().Base.built		

) :=
module

	shared dUpdate := Strata_Stats(pBaseFile);
	
	dGeneric_Strata		:= dUpdate.dNoGrouping		;
	dSubjectSt_Strata	:= dUpdate.dSubjectState	;
	dSource_Strata		:= dUpdate.dSource				;

	strata.createXMLStats(dGeneric_Strata		,_Dataset().Name, 'base', pversion, email_notification_lists.buildsuccess, BuildGeneric_Strata		,'View'										,'Population');
	strata.createXMLStats(dSubjectSt_Strata	,_Dataset().Name, 'base', pversion, email_notification_lists.buildsuccess, BuildSubjectSt_Strata	,'Subject_Address_State'	,'Population');
	strata.createXMLStats(dSource_Strata		,_Dataset().Name, 'base', pversion, email_notification_lists.buildsuccess, BuildSource_Strata			,'Source'									,'Population');

	hasGenericStrataBeenRun 			:= tools.fun_StrataAlreadyRun(_Dataset().Name, 'base', pversion,'View'									,'Population');
	hasSubjectStateStrataBeenRun	:= tools.fun_StrataAlreadyRun(_Dataset().Name, 'base', pversion,'Subject_Address_State'	,'Population');
	hasSourceStrataBeenRun				:= tools.fun_StrataAlreadyRun(_Dataset().Name, 'base', pversion,'Source'								,'Population');

	full_build := 
	parallel(
		 if(not hasGenericStrataBeenRun				or pOverwrite	,BuildGeneric_Strata		)
		,if(not hasSubjectStateStrataBeenRun	or pOverwrite	,BuildSubjectSt_Strata	)
		,if(not hasSourceStrataBeenRun				or pOverwrite	,BuildSource_Strata			)
	);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping POE.Build_Strata attribute')
	);
		
end;