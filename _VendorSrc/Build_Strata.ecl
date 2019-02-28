import tools,strata;
export Build_Strata( string	pversion, boolean pUseProd = false) := module

	shared dUpdate := Strata_stats(Files(pversion,pUseProd).Base.Built);
	
	Strata.createXMLStats(dUpdate.dNoGrouping,'alloy_consumer', 'base', pversion, email_notification_lists.BuildSuccess, BuildGeneric_Strata		,'View','Population');

	full_build := 
	parallel(
		 BuildGeneric_Strata		
	);

	export All := full_build;
		
end;
