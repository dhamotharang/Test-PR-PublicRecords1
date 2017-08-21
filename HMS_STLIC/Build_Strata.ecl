import tools,strata;
export Build_Strata( string	pversion, boolean pUseProd = false) := module

	shared dStateLicenseUpdate	:= Strata_stats.StateLicense(Files(pversion,pUseProd).statelicense_Base.Built);
	shared dStateLicenseRollupUpdate	:= Strata_stats.StateLicenseRollup(Files(pversion,pUseProd).stlicrollup_Base.Built);
	// shared dAddressUpdate 			:= Strata_stats.address(Files(pversion,pUseProd).address_Base.Built);


	Strata.createXMLStats(dStateLicenseUpdate.dNoGrouping,'HMS_StLic_V1', 'statelicense_base', pversion, email_notification_lists.BuildSuccess, BuildStateLicense_Strata		,'View','Population');
	
	full_build := 
	parallel(
		 BuildStateLicense_Strata		;
		
	);

	export All := full_build;
	
	Strata.createXMLStats(dStateLicenseRollupUpdate.dNoGrouping,'HMS_StLic_Rollup_V1', 'stlicrollup_base', pversion, email_notification_lists.BuildSuccess, BuildStateLicenseRollup_Strata		,'View','Population');

 	Rollup_build := 
   	parallel(
   		 BuildStateLicenseRollup_Strata		;
   		
   	);
   
  export StlRollup := Rollup_build;
		
end;
