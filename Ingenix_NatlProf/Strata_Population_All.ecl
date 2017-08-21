import strata, tools;

export Strata_Population_All(string												pversion
														 ,boolean											pIsTesting	= false
														 ,boolean											pOverwrite	= false
														 ):= function
  //PROVIDER BASE FILE
	strata.mac_Pops(Ingenix_NatlProf.Basefile_Provider_Did	,prov_pops,'filetyp');
	Strata.mac_CreateXMLStats(prov_pops,'Ingenix_NatlProf'	,'ProviderBaseV2',pversion, Email_Notification_Lists().Stats,provresults,'View','Population',,pIsTesting,pOverwrite,pShouldExport := true);
	
  //SANCTIONS BASE FILE
	strata.mac_Pops(Ingenix_NatlProf.Basefile_Sanctions_Bdid	,sanc_pops,'sanc_state');
	Strata.mac_CreateXMLStats(sanc_pops,'Ingenix_NatlProf'	,'SanctionsBaseV2',pversion, Email_Notification_Lists().Stats,sancresults,'View','Population',,pIsTesting,pOverwrite,pShouldExport := true);
	
	return if(tools.fun_IsValidVersion(pversion),
						sequential(provresults,
											 sancresults	
											)
						);
end;