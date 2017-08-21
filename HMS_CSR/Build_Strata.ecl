import tools,strata;
export Build_Strata( string	pversion, boolean pUseProd = false) := module

	shared dCsrCredentialUpdate	:= Strata_stats.CsrCredential(Files(pversion,pUseProd).csrcredential_Base.Built);
	// shared dAddressUpdate 			:= Strata_stats.address(Files(pversion,pUseProd).address_Base.Built);


	Strata.createXMLStats(dCsrCredentialUpdate.dNoGrouping,'HMS_CSR_V1', 'csrcredential_base', pversion, email_notification_lists.BuildSuccess, BuildCsrCredential_Strata		,'View','Population');
	
	full_build := 
	parallel(
		 BuildCsrCredential_Strata		;
		
	);

	export All := full_build;
		
end;
