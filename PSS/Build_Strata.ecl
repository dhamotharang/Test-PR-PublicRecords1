import tools,strata;
export Build_Strata( string	pversion, boolean pIsTesting	= false) := module

	shared dUpdate := Strata_stats(Files(pversion,pIsTesting).Base.Built);
	
	Strata.createXMLStats(dUpdate.dNoGrouping,'pss', 'base', pversion, email_notification_lists.BuildSuccess, BuildGeneric_Strata		,'View','Population');

	full_build := 
	sequential(
		 BuildGeneric_Strata		
	);

	export All := full_build;
		
end;

