import VersionControl,strata;

export Build_Strata(

	 string									pversion
	,boolean								pOverwrite	= false
	,dataset(Layouts.Base	)	pBaseFile   = Files().Base.built		

) :=
function

	dUpdate := Strata_stats(pBaseFile);
	
	dGeneric_Strata		:= dUpdate.dNoGrouping				;
	dHomeSt_Strata		:= dUpdate.dhomeaddressState	;
	dWorkSt_Strata		:= dUpdate.dworkaddressState	;

	strata.createXMLStats(dGeneric_Strata	,_Dataset().Name, 'data', pversion, email_notification_lists.buildsuccess, BuildGeneric_Strata	,'View'				,'Population');
	strata.createXMLStats(dHomeSt_Strata	,_Dataset().Name, 'data', pversion, email_notification_lists.buildsuccess, BuildHomeSt_Strata		,'home_State'	,'Population');
	strata.createXMLStats(dWorkSt_Strata	,_Dataset().Name, 'data', pversion, email_notification_lists.buildsuccess, BuildWorkSt_Strata		,'work_State'	,'Population');

	hasGenericStrataBeenRun 	:= VersionControl.fHasStrataBeenRun(_Dataset().Name, 'data', pversion,'View'				,'Population');
	hasHomeStateStrataBeenRun	:= VersionControl.fHasStrataBeenRun(_Dataset().Name, 'data', pversion,'home_State'	,'Population');
	hasWorkStateStrataBeenRun	:= VersionControl.fHasStrataBeenRun(_Dataset().Name, 'data', pversion,'work_State'	,'Population');

	full_build := 
	parallel(
		 if(not hasGenericStrataBeenRun 		or pOverwrite	,BuildGeneric_Strata	)
		,if(not hasHomeStateStrataBeenRun		or pOverwrite	,BuildHomeSt_Strata		)
		,if(not hasWorkStateStrataBeenRun		or pOverwrite	,BuildWorkSt_Strata		)
	);

	return
	if(VersionControl.IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping One_Click_Data.Build_Strata attribute')
	);
		
end;