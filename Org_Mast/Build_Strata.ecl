import tools, strata, Org_Mast;

export Build_Strata( string	pversion, boolean pUseProd = false) := module

	shared dOrganization := Org_Mast.Strata_stats.organization(Org_Mast.Files(pversion,pUseProd).Organization_Base.Built);
	shared dAffiliations := Org_Mast.Strata_stats.affiliations(Org_Mast.Files(pversion,pUseProd).Affiliations_Base.Built);
	
	
 	Strata.createXMLStats(dOrganization.dNoGrouping, 'Strata_Org_Master', 'organization_base', pversion, email_notification_lists.BuildSuccess, BuildOrganization_Strata		,'View','Population');
 	//Strata.createXMLStats(dAffiliations.dNoGrouping, 'Org_Mast', 'affiliations_base', pversion, email_notification_lists.BuildSuccess, BuildAffiliations_Strata		,'View','Population');

	full_build := 
	parallel(
		BuildOrganization_Strata  ;
		//BuildAffiliations_Strata	;
	);

	export All := full_build;
		
end;
