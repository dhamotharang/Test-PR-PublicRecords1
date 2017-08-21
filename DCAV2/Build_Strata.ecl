import tools,strata;
export Build_Strata(
	 string														pversion
	,boolean													pOverwrite					= false
	,boolean													pIsTesting					= _Constants().isdataland
	,string														pinputfileversion		= 'using'
	,string														pbasefileversion		= 'built'
	,boolean													pUseOtherEnviron		= false
	,dataset(Layouts.Input.sprayed	)	pSprayedintFile			= files(pinputfileversion,pUseOtherEnviron).input.int.logical
	,dataset(Layouts.Input.sprayed	)	pSprayedprvFile			= files(pinputfileversion,pUseOtherEnviron).input.prv.logical
	,dataset(Layouts.Input.sprayed	)	pSprayedpubFile			= files(pinputfileversion,pUseOtherEnviron).input.pub.logical
	,dataset(Layouts.Input.sprayed	)	pSprayedPrivcoFile	= files(pinputfileversion,pUseOtherEnviron).input.privco.logical
	,dataset(layouts.base.companies	)	pBaseCompanies			= files(pbasefileversion,pUseOtherEnviron).base.companies.logical
	,dataset(layouts.base.contacts	)	pBaseContacts				= files(pbasefileversion,pUseOtherEnviron).base.contacts.logical
) :=
function

	dUpdate := Strata_stats(pinputfileversion,pbasefileversion,pUseOtherEnviron,pSprayedintFile,pSprayedprvFile,pSprayedpubFile,pSprayedPrivcoFile,pBaseCompanies,pBaseContacts);
	
	BuildInputIntNoGrouping_Strata			:= Strata.macf_CreateXMLStats(dUpdate.dInputInt						,_Constants().Name	,'InputInt'				,pversion	,email_notification_lists().buildsuccess	,'View'					,'Population'	,pIsTesting,pOverwrite);
	BuildInputPRVNoGrouping_Strata			:= Strata.macf_CreateXMLStats(dUpdate.dInputPRV						,_Constants().Name	,'InputPRV'				,pversion	,email_notification_lists().buildsuccess	,'View'					,'Population'	,pIsTesting,pOverwrite);
	BuildInputPUBNoGrouping_Strata			:= Strata.macf_CreateXMLStats(dUpdate.dInputPUB						,_Constants().Name	,'InputPUB'				,pversion	,email_notification_lists().buildsuccess	,'View'					,'Population'	,pIsTesting,pOverwrite);
	BuildInputPRIVCONoGrouping_Strata	  := Strata.macf_CreateXMLStats(dUpdate.dInputPRIVCO				,_Constants().Name	,'InputPRIVCO'		,pversion	,email_notification_lists().buildsuccess	,'View'					,'Population'	,pIsTesting,pOverwrite);
	BuildInputUniqueNoGrouping_Strata	  := Strata.macf_CreateXMLStats(dUpdate.dCompaniesRecordType,_Constants().Name	,'Base_Companiesv2',pversion	,email_notification_lists().buildsuccess	,'Record_Type'	,'Population'	,pIsTesting,pOverwrite);
	BuildNoGrouping_Strata							:= Strata.macf_CreateXMLStats(dUpdate.dCompaniesUniques		,_Constants().Name	,'Base_Companiesv2',pversion	,email_notification_lists().buildsuccess	,'View'					,'Uniques'		,pIsTesting,pOverwrite);
	BuildCleanAddressState_Strata			  := Strata.macf_CreateXMLStats(dUpdate.dContactsRecordType	,_Constants().Name	,'Base_Contactsv2' ,pversion	,email_notification_lists().buildsuccess	,'Record_Type'	,'Population'	,pIsTesting,pOverwrite);
	BuildUniqueNoGrouping_Strata				:= Strata.macf_CreateXMLStats(dUpdate.dContactsUniques		,_Constants().Name	,'Base_Contactsv2' ,pversion	,email_notification_lists().buildsuccess	,'View'					,'Uniques'		,pIsTesting,pOverwrite);

	full_build := 
	parallel(
		 BuildInputIntNoGrouping_Strata		
		,BuildInputPRVNoGrouping_Strata		
		,BuildInputPUBNoGrouping_Strata				
		,BuildInputPRIVCONoGrouping_Strata		
		,BuildInputUniqueNoGrouping_Strata		
		,BuildNoGrouping_Strata								
		,BuildCleanAddressState_Strata				
		,BuildUniqueNoGrouping_Strata					
	);
	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping DCAV2.Build_Strata attribute')
	);
		
end;
