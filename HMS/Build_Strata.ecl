import tools,strata;
export Build_Strata( string	pversion, boolean pUseProd = false) := module

	shared dIndividual              := Strata_stats.Individual(Files(pversion,pUseProd).Individual_Base.Built);
	// shared dIndividualAddresses     := Strata_stats.Individual_Addresses(Files(pversion,pUseProd).Individual_Addresses_Base.Built);
	// shared dIndividualStateLicenses := Strata_stats.Individual_State_Licenses(Files(pversion,pUseProd).Individual_State_Licenses_Base.Built);
	// shared dIndividualDea           := Strata_stats.Individual_Dea(Files(pversion,pUseProd).Individual_Dea_Base.Built);
	// shared dIndividualStateCsr      := Strata_stats.Individual_State_Csr(Files(pversion,pUseProd).Individual_State_Csr_Base.Built);
	// shared dIndividualSanctions     := Strata_stats.Individual_Sanctions(Files(pversion,pUseProd).Individual_Sanctions_Base.Built);
	// shared dIndividualGsaSanctions  := Strata_stats.Individual_Gsa_Sanctions(Files(pversion,pUseProd).Individual_Gsa_Sanctions_Base.Built);
	// shared dStateLicenseTypes       := Strata_stats.State_License_Types(Files(pversion,pUseProd).State_License_Types_Base.Built);
	
	// shared dIndividualAddressFaxes      := Strata_stats.Individual_Address_Faxes(      Files(pversion,pUseProd).individual_address_faxes_Base.Built);
	// shared dIndividualAddressPhones     := Strata_stats.Individual_Address_Phones(     Files(pversion,pUseProd).individual_address_phones_Base.Built);
	// shared dIndividualCertifications    := Strata_stats.Individual_Certifications(     Files(pversion,pUseProd).individual_certifications_Base.Built);
	// shared dIndividualCoveredRecipients := Strata_stats.Inidividual_Covered_Recipients(Files(pversion,pUseProd).individual_covered_recipients_Base.Built);
	// shared dIndividualEducation         := Strata_stats.Individual_Education(          Files(pversion,pUseProd).individual_education_Base.Built);
	// shared dIndividualLanguages         := Strata_stats.Individual_Languages(          Files(pversion,pUseProd).individual_languages_Base.Built);
	// shared dIndividualSpecialty         := Strata_stats.Individual_Specialty(          Files(pversion,pUseProd).individual_specialty_Base.Built);
	// shared dPiidMigration				        := Strata_stats.Piid_Migration(                Files(pversion,pUseProd).piid_migration_base.Built);
	
	
 	Strata.createXMLStats(dIndividual.dNoGrouping,             'Strata_HMS', 'individuals_base', pversion, email_notification_lists.BuildSuccess, BuildIndividual_Strata		,'View','Population');
	// Strata.createXMLStats(dIndividualAddresses.dNoGrouping,    'hms', 'individual_addresses_base', pversion, email_notification_lists.BuildSuccess, BuildIndividual_Addresses_Strata		,'View','Population');
	// Strata.createXMLStats(dIndividualStateLicenses.dNoGrouping,'hms', 'individual_state_licenses_base', pversion, email_notification_lists.BuildSuccess, BuildIndividual_State_Licenses_Strata		,'View','Population');
	// Strata.createXMLStats(dIndividualDea.dNoGrouping,          'hms', 'individual_dea_base', pversion, email_notification_lists.BuildSuccess, BuildIndividual_Dea_Strata		,'View','Population');
	// Strata.createXMLStats(dIndividualStateCsr.dNoGrouping,     'hms', 'individual_state_csr_base', pversion, email_notification_lists.BuildSuccess, BuildIndividual_State_Csr_Strata		,'View','Population');
	// Strata.createXMLStats(dIndividualSanctions.dNoGrouping,    'hms', 'individual_sanctions_base', pversion, email_notification_lists.BuildSuccess, BuildIndividual_Sanctions_Strata		,'View','Population');
	// Strata.createXMLStats(dIndividualGsaSanctions.dNoGrouping, 'hms', 'individual_gsa_sanctions_base', pversion, email_notification_lists.BuildSuccess, BuildIndividual_Gsa_Sanctions_Strata		,'View','Population');
	// Strata.createXMLStats(dStateLicenseTypes.dNoGrouping,      'hms', 'state_license_types_base', pversion, email_notification_lists.BuildSuccess, BuildState_License_Types_Strata		,'View','Population');

	// Strata.createXMLStats(dIndividualAddressFaxes      .dNoGrouping,'hms', 'individual_address_faxes_base',        pversion, email_notification_lists.BuildSuccess, Build_individual_address_faxes_Strata		        ,'View','Population');
	// Strata.createXMLStats(dIndividualAddressPhones     .dNoGrouping,'hms', 'individual_address_phones_base',       pversion, email_notification_lists.BuildSuccess, Build_individual_address_phones_Strata				 	,'View','Population');
	// Strata.createXMLStats(dIndividualCertifications    .dNoGrouping,'hms', 'individual_certifications_base',       pversion, email_notification_lists.BuildSuccess, Build_individual_certifications_Strata				 	,'View','Population');
	// Strata.createXMLStats(dIndividualCoveredRecipients .dNoGrouping,'hms', 'individual_covered_recipients_base',   pversion, email_notification_lists.BuildSuccess, Build_individual_covered_recipients_Strata	  	,'View','Population');
	// Strata.createXMLStats(dIndividualEducation         .dNoGrouping,'hms', 'individual_education_base',            pversion, email_notification_lists.BuildSuccess, Build_individual_education_Strata		            ,'View','Population');
	// Strata.createXMLStats(dIndividualLanguages         .dNoGrouping,'hms', 'individual_languages_base',            pversion, email_notification_lists.BuildSuccess, Build_individual_languages_Strata								,'View','Population');
	// Strata.createXMLStats(dIndividualSpecialty         .dNoGrouping,'hms', 'individual_specialty_base',            pversion, email_notification_lists.BuildSuccess, Build_individual_specialty_Strata								,'View','Population');
	// Strata.createXMLStats(dPiidMigration               .dNoGrouping,'hms', 'piid_migration_base',                  pversion, email_notification_lists.BuildSuccess, Build_piid_migration_Strata											,'View','Population');

	full_build := 
	parallel(
		BuildIndividual_Strata;
		// BuildIndividual_Addresses_Strata;
		// BuildIndividual_State_Licenses_Strata;
		// BuildIndividual_Dea_Strata;
		// BuildIndividual_State_Csr_Strata;
		// BuildIndividual_Sanctions_Strata;
		// BuildIndividual_Gsa_Sanctions_Strata;		
		// BuildState_License_Types_Strata;
		
		// Build_individual_address_faxes_Strata		      ;
		// Build_individual_address_phones_Strata				;
		// Build_individual_certifications_Strata				;
		// Build_individual_covered_recipients_Strata  	;
		// Build_individual_education_Strata		          ;
		// Build_individual_languages_Strata				    	;
		// Build_individual_specialty_Strata				  		;
		// Build_piid_migration_Strata	      			  		;
	);

	export All := full_build;
		
end;
