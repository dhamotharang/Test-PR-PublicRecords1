IMPORT tools;

// currently set up to process the original large data files
// to process the smaller files for purposes of saving time during testing, reverse the commenting
// that is, comment out the uncommented lines, and uncomment the commented ones

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE
	 
	 EXPORT individual                := DATASET(Filenames(pversion,pUseProd).individual_lInputTemplate, layouts.individual_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_addresses      := DATASET(Filenames(pversion,pUseProd).individual_addresses_lInputTemplate, layouts.individual_addresses_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_dea            := DATASET(Filenames(pversion,pUseProd).individual_dea_lInputTemplate, layouts.individual_dea_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_state_licenses := DATASET(Filenames(pversion,pUseProd).individual_state_licenses_lInputTemplate, layouts.individual_state_licenses_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_state_csr 		  := DATASET(Filenames(pversion,pUseProd).individual_state_csr_lInputTemplate, layouts.individual_state_csr_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_sanctions  		:= DATASET(Filenames(pversion,pUseProd).individual_sanctions_lInputTemplate, layouts.individual_sanctions_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_gsa_sanctions  := DATASET(Filenames(pversion,pUseProd).individual_gsa_sanctions_lInputTemplate, layouts.individual_gsa_sanctions_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT state_license_types       := DATASET(Filenames(pversion,pUseProd).state_license_types_lInputTemplate, layouts.state_license_types_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));

	 EXPORT individual_address_faxes 			:= DATASET(Filenames(pversion,pUseProd).individual_address_faxes_lInputTemplate, layouts.individual_address_faxes_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_address_phones 			:= DATASET(Filenames(pversion,pUseProd).individual_address_phones_lInputTemplate, layouts.individual_address_phones_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_certifications 			:= DATASET(Filenames(pversion,pUseProd).individual_certifications_lInputTemplate, layouts.individual_certifications_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_covered_recipients		:= DATASET(Filenames(pversion,pUseProd).individual_covered_recipients_lInputTemplate, layouts.individual_covered_recipients_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_education 			:= DATASET(Filenames(pversion,pUseProd).individual_education_lInputTemplate, layouts.individual_education_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_languages 			:= DATASET(Filenames(pversion,pUseProd).individual_languages_lInputTemplate, layouts.individual_languages_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT individual_specialty 			:= DATASET(Filenames(pversion,pUseProd).individual_specialty_lInputTemplate, layouts.individual_specialty_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT piid_migration      			:= DATASET(Filenames(pversion,pUseProd).piid_migration_lInputTemplate, layouts.piid_migration_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));

	 /* Base File Versions */
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_base, layouts.individual_base, individual_base);
   tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_addresses_base, layouts.individual_addresses_base, individual_addresses_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_dea_base, layouts.individual_dea_base, individual_dea_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_sanctions_base, layouts.individual_sanctions_base, individual_sanctions_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_state_licenses_base, layouts.individual_state_licenses_base, individual_state_licenses_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_state_csr_base, layouts.individual_state_csr_base, individual_state_csr_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_gsa_sanctions_base, layouts.individual_gsa_sanctions_base, individual_gsa_sanctions_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).state_license_types_base, layouts.state_license_types_base, state_license_types_base);
	 	 
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_address_faxes_base, layouts.individual_address_faxes_base, individual_address_faxes_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_address_phones_base, layouts.individual_address_phones_base, individual_address_phones_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_certifications_base, layouts.individual_certifications_base, individual_certifications_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_covered_recipients_base, layouts.individual_covered_recipients_base, individual_covered_recipients_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_education_base, layouts.individual_education_base, individual_education_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_languages_base, layouts.individual_languages_base, individual_languages_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_specialty_base, layouts.individual_specialty_base, individual_specialty_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).piid_migration_base, layouts.piid_migration_base, piid_migration_base);
	 
END;