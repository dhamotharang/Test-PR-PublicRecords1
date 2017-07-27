import tools,strata;

export Build_Strata(

	 string															pversion
	,boolean														pOverwrite				= false
	,dataset( VINA.layout_vina_infile	)	pBaseFile   			= VINA.file_vina_infile		
	,boolean														pIsTesting				= tools._Constants.IsDataland

) :=
function

	dUpdate := Vina.Strata_Stats(pBaseFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping, 'Vina', 'data', pversion, Vina.email_notification_lists().buildsuccess, BuildNoGrouping_Strata, 'View', 'Population',,pIsTesting,pOverwrite);

	full_build := 
	parallel(
		 BuildNoGrouping_Strata								
  );

	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping VINA.Build_Strata attribute')
	);
		
end;