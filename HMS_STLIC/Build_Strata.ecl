import tools,strata;
export Build_Strata( string	pversion, boolean pUseProd = false) := module

	shared dStateLicenseUpdate	:= Strata_stats.StateLicense(Files(pversion,pUseProd).statelicense_Base.Built);
	// shared dAddressUpdate 			:= Strata_stats.address(Files(pversion,pUseProd).address_Base.Built);


	Strata.createXMLStats(dStateLicenseUpdate.dNoGrouping,'HMS_StLic_V1', 'statelicense_base', pversion, email_notification_lists.BuildSuccess, BuildStateLicense_Strata		,'View','Population');
	
	full_build := 
	parallel(
		 BuildStateLicense_Strata		;
		
	);

	export All := full_build;
		
end;
