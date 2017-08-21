import tools,strata;
export Build_Strata( string	pversion) := module

	shared dUpdate := Strata_stats(Experian_Phones.Files.base);
	
	Strata.createXMLStats(dUpdate.dNoGrouping,'ExpPhonev2', 'base', pversion, Send_Email(pversion).email_list_success, BuildGeneric_Strata		,'View','Population');
	Strata.createXMLStats(dUpdate.dphonepos	,'ExpPhonev2', 'base', pversion, Send_Email(pversion).email_list_success, BuildPhonePos_Strata	,'Phone_Position'	,'Population');
	Strata.createXMLStats(dUpdate.dphonetype,'ExpPhonev2', 'base', pversion, Send_Email(pversion).email_list_success, BuildPhoneType_Strata,'Phone_Type','Population');
	Strata.createXMLStats(dUpdate.dphonesrc,'ExpPhonev2', 'base', pversion, Send_Email(pversion).email_list_success, BuildPhoneSource_Strata,'Phone_Source','Population');
		
	full_build := 
	parallel(
		 BuildGeneric_Strata		
		,BuildPhonePos_Strata	
		,BuildPhoneType_Strata	
		,BuildPhoneSource_Strata			
	);

	export All := full_build;
		
end;
