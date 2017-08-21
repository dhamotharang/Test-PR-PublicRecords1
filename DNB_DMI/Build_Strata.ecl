import tools,strata;
export Build_Strata(
	 string																	pversion
	,boolean																pOverwrite					= false
	,dataset(Layouts.Input.Sprayed		)			pPrepSprayedFile		= Prep_File()
	,dataset(layouts.base.companiesforBip2)	pBaseCompaniesFile	= files().base.companies.built
	,dataset(layouts.base.contacts		)			pBaseContactsFile		= files().base.contacts.built
	,boolean																pIsTesting					= _Constants().IsDataland
) :=
function

	dUpdate := Strata_stats(pPrepSprayedFile,pBaseCompaniesFile,pBaseContactsFile);
	
	Strata.mac_CreateXMLStats(dUpdate.dInputNoGrouping													,_Constants().Name	,'Input'					,pversion	,email_notification_lists().buildsuccess	,BuildInputNoGrouping_Strata												,'View'												,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dBaseNoGrouping														,_Constants().Name	,'Company BaseV2'	,pversion	,email_notification_lists().buildsuccess	,BuildBaseNoGrouping_Strata													,'View'												,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dBaseCleanMailAddressState								,_Constants().Name	,'Company BaseV2'	,pversion	,email_notification_lists().buildsuccess	,BuildBaseCleanMailAddressState_Strata							,'clean_mail_address_state'		,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dBaseCleanAddressState										,_Constants().Name	,'Company BaseV2'	,pversion	,email_notification_lists().buildsuccess	,BuildBaseCleanAddressState_Strata									,'Clean_address_state'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dBaseRecordType														,_Constants().Name	,'Company BaseV2'	,pversion	,email_notification_lists().buildsuccess	,BuildBaseRecordType_Strata													,'record_type'								,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dBaseActiveDunsNumber											,_Constants().Name	,'Company BaseV2'	,pversion	,email_notification_lists().buildsuccess	,BuildBaseActiveDunsNumber_Strata										,'active_duns_number'					,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniquesBaseNoGrouping										,_Constants().Name	,'Company BaseV2'	,pversion	,email_notification_lists().buildsuccess	,BuildUniquesBaseNoGrouping_Strata									,'View'												,'Uniques'		,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dContactsNoGrouping												,_Constants().Name	,'Contacts base'	,pversion	,email_notification_lists().buildsuccess	,BuildContactsNoGrouping_Strata											,'View'												,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dContactsCleanCompanyAddressState					,_Constants().Name	,'Contacts base'	,pversion	,email_notification_lists().buildsuccess	,BuildContactsCleanCompanyAddressState_Strata				,'clean_company_address_state','Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dContactsRecordType												,_Constants().Name	,'Contacts base'	,pversion	,email_notification_lists().buildsuccess	,BuildContactsRecordType_Strata											,'record_type'								,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dContactsCompanyRecordType								,_Constants().Name	,'Contacts base'	,pversion	,email_notification_lists().buildsuccess	,BuildContactsCompanyRecordType_Strata							,'company_record_type'				,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dContactsActiveDunsNumber									,_Constants().Name	,'Contacts base'	,pversion	,email_notification_lists().buildsuccess	,BuildContactsActiveDunsNumber_Strata								,'active_duns_number'					,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dUpdate.dUniquesContactsNoGrouping								,_Constants().Name	,'Contacts base'	,pversion	,email_notification_lists().buildsuccess	,BuildUniquesContactsNoGrouping_Strata							,'View'												,'Uniques'		,,pIsTesting,pOverwrite);
                                                                                                                                                                 
	full_build :=                                                                                                                                                  
	parallel(                                                                                                                                                      
		 BuildInputNoGrouping_Strata									
		,BuildBaseNoGrouping_Strata										
		,BuildBaseCleanMailAddressState_Strata					
		,BuildBaseCleanAddressState_Strata							
		,BuildBaseRecordType_Strata											
		,BuildBaseActiveDunsNumber_Strata								
		,BuildUniquesBaseNoGrouping_Strata						
		,BuildContactsNoGrouping_Strata								
		,BuildContactsCleanCompanyAddressState_Strata		
		,BuildContactsRecordType_Strata									
		,BuildContactsCompanyRecordType_Strata					
		,BuildContactsActiveDunsNumber_Strata						
		,BuildUniquesContactsNoGrouping_Strata				
	);
	return
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping DNB_DMI.Build_Strata attribute')
	);
		
end;
