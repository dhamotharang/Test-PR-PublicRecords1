import tools,strata;
export Build_Strata( string	pversion, boolean pUseProd = false) := module

	shared dAddressUpdate 			:= Strata_stats.address(Files(pversion,pUseProd).address_Base.Built);
	shared dAssociateUpdate 		:= Strata_stats.associate(Files(pversion,pUseProd).associate_Base.Built);
	shared dDEAUpdate 					:= Strata_stats.dea(Files(pversion,pUseProd).dea_Base.Built);
	shared dFacilityUpdate 			:= Strata_stats.facility(Files(pversion,pUseProd).facility_Base.Built);
	shared dIndividualUpdate 		:= Strata_stats.individual(Files(pversion,pUseProd).individual_Base.Built);
	shared dLicenseUpdate 			:= Strata_stats.license(Files(pversion,pUseProd).license_Base.Built);
	shared dMedschoolUpdate 		:= Strata_stats.medschool(Files(pversion,pUseProd).medschool_Base.Built);
	shared dNPIUpdate 					:= Strata_stats.npi(Files(pversion,pUseProd).npi_Base.Built);
	shared dProvBirthdateUpdate := Strata_stats.prov_birthdate(Files(pversion,pUseProd).prov_birthdate_Base.Built);
	shared dProvSSNUpdate 			:= Strata_stats.prov_ssn(Files(pversion,pUseProd).prov_ssn_Base.Built);
	shared dSancCodesUpdate 		:= Strata_stats.sanc_codes(Files(pversion,pUseProd).sanc_codes_Base.Built);
	shared dSancProvTypeUpdate 	:= Strata_stats.sanc_prov_type(Files(pversion,pUseProd).sanc_prov_type_Base.Built);
	shared dSanctionUpdate 			:= Strata_stats.sanction(Files(pversion,pUseProd).sanction_Base.Built);
	shared dSpecialtyUpdate 		:= Strata_stats.specialty(Files(pversion,pUseProd).specialty_Base.Built);
	shared dTaxCodesUpdate			:= Strata_stats.tax_codes(Files(pversion,pUseProd).tax_codes_Base.Built);
	shared dTaxonomyUpdate 			:= Strata_stats.taxonomy(Files(pversion,pUseProd).taxonomy_Base.Built);
	shared dCollapseUpdate 			:= Strata_stats.Collapse(Files(pversion,pUseProd).Collapse_Base.Built);
	shared dSplitUpdate 			:= Strata_stats.Split(Files(pversion,pUseProd).Split_Base.Built);
	shared dDropUpdate 			:= Strata_stats.Drop(Files(pversion,pUseProd).Drop_Base.Built);

	Strata.createXMLStats(dAddressUpdate.dNoGrouping,'enclarity_v2', 'address_base', pversion, email_notification_lists.BuildSuccess, BuildAddress_Strata		,'View','Population');
	Strata.createXMLStats(dAssociateUpdate.dNoGrouping,'enclarity_v2', 'associate_base', pversion, email_notification_lists.BuildSuccess, BuildAssociate_Strata		,'View','Population');
	Strata.createXMLStats(dDEAUpdate.dNoGrouping,'enclarity_v2', 'dea_base', pversion, email_notification_lists.BuildSuccess, BuildDEA_Strata		,'View','Population');
	Strata.createXMLStats(dFacilityUpdate.dNoGrouping,'enclarity_v3', 'facility_base', pversion, email_notification_lists.BuildSuccess, BuildFacility_Strata		,'View','Population');
	Strata.createXMLStats(dIndividualUpdate.dNoGrouping,'enclarity_v2', 'individual_base', pversion, email_notification_lists.BuildSuccess, BuildIndividual_Strata		,'View','Population');
	Strata.createXMLStats(dLicenseUpdate.dNoGrouping,'enclarity_v2', 'license_base', pversion, email_notification_lists.BuildSuccess, BuildLicense_Strata		,'View','Population');
	Strata.createXMLStats(dMedschoolUpdate.dNoGrouping,'enclarity_v2', 'medschool_base', pversion, email_notification_lists.BuildSuccess, BuildMedschool_Strata		,'View','Population');
	Strata.createXMLStats(dNPIUpdate.dNoGrouping,'enclarity_v2', 'npi_base', pversion, email_notification_lists.BuildSuccess, BuildNPI_Strata		,'View','Population');
	Strata.createXMLStats(dProvBirthdateUpdate.dNoGrouping,'enclarity_v2', 'prov_birthdate_base', pversion, email_notification_lists.BuildSuccess, BuildProvBirthdate_Strata		,'View','Population');
	Strata.createXMLStats(dProvSSNUpdate.dNoGrouping,'enclarity_v2', 'prov_ssn_base', pversion, email_notification_lists.BuildSuccess, BuildProvSSN_Strata		,'View','Population');
	Strata.createXMLStats(dSancCodesUpdate.dNoGrouping,'enclarity_v2', 'sanc_codes_base', pversion, email_notification_lists.BuildSuccess, BuildSancCodes_Strata		,'View','Population');
	Strata.createXMLStats(dSancProvTypeUpdate.dNoGrouping,'enclarity_v2', 'sanc_prov_type_base', pversion, email_notification_lists.BuildSuccess, BuildSancProvType_Strata		,'View','Population');
	Strata.createXMLStats(dSanctionUpdate.dNoGrouping,'enclarity_v2', 'sanction_base', pversion, email_notification_lists.BuildSuccess, BuildSanction_Strata		,'View','Population');
	Strata.createXMLStats(dSpecialtyUpdate.dNoGrouping,'enclarity_v2', 'specialty_base', pversion, email_notification_lists.BuildSuccess, BuildSpecialty_Strata		,'View','Population');
	Strata.createXMLStats(dTaxCodesUpdate.dNoGrouping,'enclarity_v2', 'tax_codes_base', pversion, email_notification_lists.BuildSuccess, BuildTaxCodes_Strata		,'View','Population');
	Strata.createXMLStats(dTaxonomyUpdate.dNoGrouping,'enclarity_v2', 'taxonomy_base', pversion, email_notification_lists.BuildSuccess, BuildTaxonomy_Strata		,'View','Population');
	Strata.createXMLStats(dCollapseUpdate.dNoGrouping,'enclarity_v2', 'collapse_base', pversion, email_notification_lists.BuildSuccess, Buildcollapse_Strata		,'View','Population');
	Strata.createXMLStats(dsplitUpdate.dNoGrouping,'enclarity_v2', 'split_base', pversion, email_notification_lists.BuildSuccess, Buildsplit_Strata		,'View','Population');
	Strata.createXMLStats(ddropUpdate.dNoGrouping,'enclarity_v2', 'drop_base', pversion, email_notification_lists.BuildSuccess, Builddrop_Strata		,'View','Population');
	
	full_build := 
	parallel(
		 BuildAddress_Strata		;
		 BuildAssociate_Strata	;
		 BuildDEA_Strata				;
		 BuildFacility_Strata		;
		 BuildIndividual_Strata	;
		 BuildLicense_Strata		;
		 BuildMedschool_Strata	;
		 BuildNPI_Strata				;
		 BuildProvBirthdate_Strata;
		 BuildProvSSN_Strata		;
		 BuildSancCodes_Strata	;
		 BuildSancProvType_Strata;
		 BuildSanction_Strata		;
		 BuildSpecialty_Strata	;
		 BuildTaxCodes_Strata		;
		 BuildTaxonomy_Strata		;
		 Buildcollapse_Strata		;
		 Buildsplit_Strata		;
		 Builddrop_Strata		;
	);

	export All := full_build;
		
end;
