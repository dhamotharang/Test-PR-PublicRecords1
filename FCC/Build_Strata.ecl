IMPORT tools, Strata;

EXPORT Build_Strata(

	 STRING															pversion
	,BOOLEAN														pOverwrite				= FALSE
	,DATASET(Layout_FCC_base_bip_AID  )	pBaseFile   			= FCC.File_FCC_base_bip_AID
	,DATASET(Layout_FCC_Licenses_in 	)	pSprayedFile			= FCC.File_FCC_licenses_in
	,BOOLEAN														pIsTesting				= tools._Constants.IsDataland

) :=
function

	dUpdate := Strata_stats(pBaseFile,pSprayedFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dInputNoGrouping					,_Constants().Name	,'Input'			,pversion	,email_notification_lists().stats	,BuildInputNoGrouping_Strata					,'View'					    ,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueInputNoGrouping		,_Constants().Name	,'Input'			,pversion	,email_notification_lists().stats	,BuildInputUniqueNoGrouping_Strata		,'View'					    ,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dLicenseesState				    ,_Constants().Name	,'base_file'	,pversion	,email_notification_lists().stats	,BuildLicenseesState_Strata				    ,'licensees_state'	,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueLicenseesState	    ,_Constants().Name	,'base_file'	,pversion	,email_notification_lists().stats	,BuildUniqueLicenseesState_Strata	    ,'licensees_state'	,'Uniques'		,,pIsTesting,pOverwrite);

	full_build := 
	parallel(
		 BuildInputNoGrouping_Strata			
		,BuildInputUniqueNoGrouping_Strata						
		,BuildLicenseesState_Strata							
		,BuildUniqueLicenseesState_Strata	
	);

	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping FCC.Build_Strata attribute')
	);
		
end;