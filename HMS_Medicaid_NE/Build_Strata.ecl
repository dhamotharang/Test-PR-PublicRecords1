import tools,strata, HMS_Medicaid_NE,HMS_Medicaid_Common;

export Build_Strata( string	pversion, boolean pUseProd = false) := module

	shared dUpdate := HMS_Medicaid_NE.Strata_stats.Medicaid_NE(HMS_Medicaid_NE.Files(pversion,pUseProd).Base.Built);
	
	Strata.createXMLStats(dUpdate.dNoGrouping,'Strata_Medicaid_NE', 'base', pversion, HMS_Medicaid_Common.email_notification_lists('NE',pversion).BuildSuccess, BuildGeneric_Strata		,'View','Population');

	full_build := 
	parallel(
		 BuildGeneric_Strata		
	);

	export All := full_build;
		
end;