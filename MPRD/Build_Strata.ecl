import tools,strata;
export Build_Strata( string	pversion, boolean pUseProd = false) := module

	// shared dFacilityUpdate 			:= Strata_stats.facility(Files(pversion,pUseProd).facility_Base.Built);
	shared dIndividualUpdate 		:= Strata_stats.individual(Files(pversion,pUseProd).individual_Base.Built);
	// shared dBascClaimsUpdate 		:= Strata_stats.basc_claims(Files(pversion,pUseProd).basc_claims_base.Built);
	// shared dChoicepointUpdate 	:= Strata_stats.basc_cp(Files(pversion,pUseProd).basc_cp_base.Built);
	// shared dBascAddrUpdate 			:= Strata_stats.basc_addr(Files(pversion,pUseProd).basc_addr_Base.Built);
	
	// Strata.createXMLStats(dFacilityUpdate.dNoGrouping,'mprd', 'facility_base', pversion, email_notification_lists.BuildSuccess, BuildFacility_Strata		,'View','Population');
	Strata.createXMLStats(dIndividualUpdate.dNoGrouping,'mprd', 'individual_base', pversion, email_notification_lists.BuildSuccess, BuildIndividual_Strata		,'View','Population');
	// Strata.createXMLStats(dBascClaimsUpdate.dNoGrouping,'mprd', 'basc_claims_base', pversion, email_notification_lists.BuildSuccess, BuildBascClaims_Strata		,'View','Population');
	// Strata.createXMLStats(dChoicepointUpdate.dNoGrouping,'mprd', 'choice_point_base', pversion, email_notification_lists.BuildSuccess, BuildChoicePoint_Strata		,'View','Population');
	// Strata.createXMLStats(dBascAddrUpdate.dNoGrouping,'mprd', 'basc_addr_base', pversion, email_notification_lists.BuildSuccess, BuildBascAddr_Strata		,'View','Population');

	full_build := 
		// parallel(
			 // BuildFacility_Strata		;
			 BuildIndividual_Strata	;
			 // BuildBascClaims_Strata ;
			 // BuildChoicePoint_Strata ;
			 // BuildBascAddr_Strata ;
		// );

	export All := full_build;
		
end;
