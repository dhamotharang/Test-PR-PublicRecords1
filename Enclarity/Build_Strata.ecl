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

	Strata.createXMLStats(dAddressUpdate.dNoGrouping,'enclarity', 'address_base', pversion, email_notification_lists.BuildSuccess, BuildAddress_Strata		,'View','Population');
	Strata.createXMLStats(dAssociateUpdate.dNoGrouping,'enclarity', 'associate_base', pversion, email_notification_lists.BuildSuccess, BuildAssociate_Strata		,'View','Population');
	Strata.createXMLStats(dDEAUpdate.dNoGrouping,'enclarity', 'dea_base', pversion, email_notification_lists.BuildSuccess, BuildDEA_Strata		,'View','Population');
	Strata.createXMLStats(dFacilityUpdate.dNoGrouping,'enclarity', 'facility_base', pversion, email_notification_lists.BuildSuccess, BuildFacility_Strata		,'View','Population');
	Strata.createXMLStats(dIndividualUpdate.dNoGrouping,'enclarity', 'individual_base', pversion, email_notification_lists.BuildSuccess, BuildIndividual_Strata		,'View','Population');
	Strata.createXMLStats(dLicenseUpdate.dNoGrouping,'enclarity', 'license_base', pversion, email_notification_lists.BuildSuccess, BuildLicense_Strata		,'View','Population');
	Strata.createXMLStats(dMedschoolUpdate.dNoGrouping,'enclarity', 'medschool_base', pversion, email_notification_lists.BuildSuccess, BuildMedschool_Strata		,'View','Population');
	Strata.createXMLStats(dNPIUpdate.dNoGrouping,'enclarity', 'npi_base', pversion, email_notification_lists.BuildSuccess, BuildNPI_Strata		,'View','Population');
	Strata.createXMLStats(dProvBirthdateUpdate.dNoGrouping,'enclarity', 'prov_birthdate_base', pversion, email_notification_lists.BuildSuccess, BuildProvBirthdate_Strata		,'View','Population');
	Strata.createXMLStats(dProvSSNUpdate.dNoGrouping,'enclarity', 'prov_ssn_base', pversion, email_notification_lists.BuildSuccess, BuildProvSSN_Strata		,'View','Population');
	Strata.createXMLStats(dSancCodesUpdate.dNoGrouping,'enclarity', 'sanc_codes_base', pversion, email_notification_lists.BuildSuccess, BuildSancCodes_Strata		,'View','Population');
	Strata.createXMLStats(dSancProvTypeUpdate.dNoGrouping,'enclarity', 'sanc_prov_type_base', pversion, email_notification_lists.BuildSuccess, BuildSancProvType_Strata		,'View','Population');
	Strata.createXMLStats(dSanctionUpdate.dNoGrouping,'enclarity', 'sanction_base', pversion, email_notification_lists.BuildSuccess, BuildSanction_Strata		,'View','Population');
	Strata.createXMLStats(dSpecialtyUpdate.dNoGrouping,'enclarity', 'specialty_base', pversion, email_notification_lists.BuildSuccess, BuildSpecialty_Strata		,'View','Population');
	Strata.createXMLStats(dTaxCodesUpdate.dNoGrouping,'enclarity', 'tax_codes_base', pversion, email_notification_lists.BuildSuccess, BuildTaxCodes_Strata		,'View','Population');
	Strata.createXMLStats(dTaxonomyUpdate.dNoGrouping,'enclarity', 'taxonomy_base', pversion, email_notification_lists.BuildSuccess, BuildTaxonomy_Strata		,'View','Population');
	Strata.createXMLStats(dCollapseUpdate.dNoGrouping,'enclarity', 'collapse_base', pversion, email_notification_lists.BuildSuccess, Buildcollapse_Strata		,'View','Population');
	Strata.createXMLStats(dsplitUpdate.dNoGrouping,'enclarity', 'split_base', pversion, email_notification_lists.BuildSuccess, Buildsplit_Strata		,'View','Population');
	Strata.createXMLStats(ddropUpdate.dNoGrouping,'enclarity', 'drop_base', pversion, email_notification_lists.BuildSuccess, Builddrop_Strata		,'View','Population');
	
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
