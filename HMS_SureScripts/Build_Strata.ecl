import tools,strata, HMS_SureScripts;
// pversion := '20150604'; // Just for test
// pUseProd := false;			 // Just for test
export Build_Strata( string	pversion, boolean pUseProd = false) := module

	shared dUpdate := HMS_SureScripts.Strata_stats.SureScripts(HMS_SureScripts.Files(pversion,pUseProd).Base.Built);
	
	Strata.createXMLStats(dUpdate.dNoGrouping,'Strata_SureScripts', 'base', pversion, HMS_SureScripts.email_notification_lists.BuildSuccess, BuildGeneric_Strata		,'View','Population');

	full_build := 
	parallel(
		 BuildGeneric_Strata		
	);

	export All := full_build;
		
end;
