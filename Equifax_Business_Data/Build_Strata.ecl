IMPORT tools, strata;

EXPORT Build_Strata(
	 STRING													pversion
	,BOOLEAN											  pOverwrite				            = FALSE
	,DATASET(Layouts.Base)	        pBaseFile   			            = Equifax_Business_Data.Files().Base.Companies.built			
	,STRING												  pfileversion			            = 'using'
	,BOOLEAN												pUseOtherEnviron	            = Equifax_Business_Data._Constants().isdataland
	,DATASET(Layouts.Sprayed_Input) pSprayedFile                  = Equifax_Business_Data.Files(pfileversion,pUseOtherEnviron).Input.Companies.logical
	,BOOLEAN											  pIsTesting				            = tools._Constants.IsDataland		
	,DATASET(Layouts.Base_Contacts)	pBaseContactsFile             = Equifax_Business_Data.Files().Base.Contacts.built
	,DATASET(Layouts.Sprayed_Input_Contacts) pSprayedContactsFile = Equifax_Business_Data.Files(pfileversion,pUseOtherEnviron).Input.Contacts.logical
) := FUNCTION

	dUpdate := Equifax_Business_Data.Strata_stats(pBaseFile,pfileversion,pUseOtherEnviron,pSprayedFile,pBaseContactsFile,pSprayedContactsFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dInputNoGrouping					,Equifax_Business_Data._Constants().Name	,'Input'	   ,pversion	,Equifax_Business_Data.email_notification_lists().buildsuccess	,BuildInputNoGrouping_Strata					,'View'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueInputNoGrouping		,Equifax_Business_Data._Constants().Name	,'Input'	   ,pversion	,Equifax_Business_Data.email_notification_lists().buildsuccess	,BuildInputUniqueNoGrouping_Strata		,'View'				,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dNoGrouping								,Equifax_Business_Data._Constants().Name	,'base_file' ,pversion	,Equifax_Business_Data.email_notification_lists().buildsuccess	,BuildNoGrouping_Strata								,'View'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dCleanAddressState				,Equifax_Business_Data._Constants().Name	,'base_file' ,pversion	,Equifax_Business_Data.email_notification_lists().buildsuccess	,BuildCleanAddressState_Strata				,'Clean_State'	,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueNoGrouping					,Equifax_Business_Data._Constants().Name	,'base_file' ,pversion	,Equifax_Business_Data.email_notification_lists().buildsuccess	,BuildUniqueNoGrouping_Strata					,'View'				,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniqueCleanAddressState	,Equifax_Business_Data._Constants().Name	,'base_file' ,pversion	,Equifax_Business_Data.email_notification_lists().buildsuccess	,BuildUniqueCleanAddressState_Strata	,'Clean_State'	,'Uniques'		,,pIsTesting,pOverwrite);
	
	Strata.mac_CreateXMLStats(dUpdate.dContactsNoGrouping					  ,Equifax_Business_Data._Constants().Name	,'Contacts Input'	   ,pversion	,Equifax_Business_Data.email_notification_lists().buildsuccess	,BuildContactsNoGrouping_Strata					,'View'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dContactsUniqueNoGrouping		,Equifax_Business_Data._Constants().Name	,'Contacts Input'	   ,pversion	,Equifax_Business_Data.email_notification_lists().buildsuccess	,BuildContactsUniqueNoGrouping_Strata		,'View'				,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dBaseContactsNoGrouping				,Equifax_Business_Data._Constants().Name	,'Contacts base_file' ,pversion	,Equifax_Business_Data.email_notification_lists().buildsuccess	,BuildContactsBaseNoGrouping_Strata								,'View'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dBaseContactsUniqueNoGrouping	,Equifax_Business_Data._Constants().Name	,'Contacts base_file' ,pversion	,Equifax_Business_Data.email_notification_lists().buildsuccess	,BuildContactsBaseUniqueNoGrouping_Strata					,'View'				,'Uniques'		,,pIsTesting,pOverwrite);
		
	full_build := PARALLEL(
		 BuildInputNoGrouping_Strata			
		,BuildInputUniqueNoGrouping_Strata
		,BuildNoGrouping_Strata								
		,BuildCleanAddressState_Strata				
		,BuildUniqueNoGrouping_Strata					
		,BuildUniqueCleanAddressState_Strata
		,BuildContactsNoGrouping_Strata			
		,BuildContactsUniqueNoGrouping_Strata
		,BuildContactsBaseNoGrouping_Strata					
		,BuildContactsBaseUniqueNoGrouping_Strata	
		):INDEPENDENT;		

	RETURN IF(tools.fun_IsValidVersion(pversion)
		       ,full_build		
		       ,OUTPUT('No Valid version parameter passed, skipping Equifax_Business_Data.Build_Strata attribute'));
		
END;