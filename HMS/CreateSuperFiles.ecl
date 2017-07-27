IMPORT HMS;

EXPORT CreateSuperFiles(string pversion = '', boolean pUseProd = false) := MODULE


    EXPORT CreateSF_individual() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_addresses() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_addresses_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_addresses_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_addresses_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_state_licenses() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_state_licenses_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_state_licenses_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_state_licenses_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_dea() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_dea_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_dea_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_dea_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_state_csr() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_state_csr_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_state_csr_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_state_csr_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_sanctions() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_sanctions_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_sanctions_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_sanctions_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_gsa_sanctions() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_gsa_sanctions_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_gsa_sanctions_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_gsa_sanctions_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_state_license_types() :=    MODULE
			sfName := Filenames(pversion, pUseProd).state_license_types_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_state_license_types_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).state_license_types_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_address_faxes() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_address_faxes_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_address_faxes_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_address_faxes_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_address_phones() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_address_phones_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_address_phones_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_address_phones_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_certifications() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_certifications_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_certifications_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_certifications_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_covered_recipients() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_covered_recipients_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_covered_recipients_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_covered_recipients_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_education() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_education_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_education_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_education_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_languages() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_languages_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_languages_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_languages_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_specialty() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_specialty_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
		
    EXPORT CreateSF_individual_specialty_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).individual_specialty_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
		
    EXPORT CreateSF_piid_migration() :=    MODULE
			sfName := Filenames(pversion, pUseProd).piid_migration_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_piid_migration_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).piid_migration_lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

   EXPORT CreateSF_All :=  PARALLEL(
    CreateSF_individual().create_sf;
    CreateSF_individual_history().create_sf;
    CreateSF_individual_addresses().create_sf; 
    CreateSF_individual_addresses_history().create_sf; 
		CreateSF_individual_state_licenses().create_sf;     
		CreateSF_individual_state_licenses_history().create_sf;     
    CreateSF_individual_dea().create_sf;     
    CreateSF_individual_dea_history().create_sf;     
    CreateSF_individual_state_csr().create_sf;     
    CreateSF_individual_state_csr_history().create_sf;     
    CreateSF_individual_sanctions().create_sf;     
    CreateSF_individual_sanctions_history().create_sf;     
    CreateSF_individual_gsa_sanctions().create_sf;     
    CreateSF_individual_gsa_sanctions_history().create_sf;     
    CreateSF_state_license_types().create_sf;     
    CreateSF_state_license_types_history().create_sf;     
    CreateSF_individual_address_faxes().create_sf;     
    CreateSF_individual_address_faxes_history().create_sf;     
    CreateSF_individual_address_phones().create_sf;     
    CreateSF_individual_address_phones_history().create_sf;     
    CreateSF_individual_certifications().create_sf;     
    CreateSF_individual_certifications_history().create_sf;     
    CreateSF_individual_covered_recipients().create_sf;     
    CreateSF_individual_covered_recipients_history().create_sf;     
    CreateSF_individual_education().create_sf;     
    CreateSF_individual_education_history().create_sf;     
    CreateSF_individual_languages().create_sf;     
    CreateSF_individual_languages_history().create_sf;     
    CreateSF_individual_specialty().create_sf;     
    CreateSF_individual_specialty_history().create_sf;     
    CreateSF_piid_migration().create_sf;     
    CreateSF_piid_migration_history().create_sf;     
  );

END;
