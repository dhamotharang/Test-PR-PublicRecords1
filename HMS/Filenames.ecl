import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module

  export individual_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individuals::built';
	export individual_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individuals::@version@';
	export individual_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individuals::@version@';	
	export individual_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individuals' ;
	export individual_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individuals::history';
	export individual_Base		            := tools.mod_FilenamesBuild(individual_lBaseTemplate, pversion);  

  export individual_addresses_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_addresses::built';
	export individual_addresses_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_addresses::@version@';
	export individual_addresses_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_addresses::@version@';	
	export individual_addresses_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_addresses' ;
	export individual_addresses_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_addresses::history';
	export individual_addresses_Base		            := tools.mod_FilenamesBuild(individual_addresses_lBaseTemplate, pversion);  
	
	export individual_state_licenses_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_state_licenses::built';
	export individual_state_licenses_lBaseTemplate	     :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_state_licenses::@version@';
	export individual_state_licenses_lKeyTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_state_licenses::@version@';	
	export individual_state_licenses_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_state_licenses' ;
	export individual_state_licenses_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_state_licenses::history';
	export individual_state_licenses_Base		             := tools.mod_FilenamesBuild(individual_state_licenses_lBaseTemplate, pversion);  
	
  export individual_dea_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_dea::built';
	export individual_dea_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_dea::@version@';
	export individual_dea_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_dea::@version@';	
	export individual_dea_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_dea' ;
	export individual_dea_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_dea::history';
	export individual_dea_Base		            := tools.mod_FilenamesBuild(individual_dea_lBaseTemplate, pversion);  
	
  export individual_state_csr_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_state_csr::built';
	export individual_state_csr_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_state_csr::@version@';
	export individual_state_csr_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_state_csr::@version@';	
	export individual_state_csr_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_state_csr' ;
	export individual_state_csr_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_state_csr::history';
	export individual_state_csr_Base		            := tools.mod_FilenamesBuild(individual_state_csr_lBaseTemplate, pversion);  

  export individual_sanctions_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_sanctions::built';
	export individual_sanctions_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_sanctions::@version@';
	export individual_sanctions_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_sanctions::@version@';	
	export individual_sanctions_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_sanctions' ;
	export individual_sanctions_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_sanctions::history';
	export individual_sanctions_Base		            := tools.mod_FilenamesBuild(individual_sanctions_lBaseTemplate, pversion);  

  export individual_gsa_sanctions_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_gsa_sanctions::built';
	export individual_gsa_sanctions_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_gsa_sanctions::@version@';
	export individual_gsa_sanctions_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_gsa_sanctions::@version@';	
	export individual_gsa_sanctions_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_gsa_sanctions' ;
	export individual_gsa_sanctions_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_gsa_sanctions::history';
	export individual_gsa_sanctions_Base		            := tools.mod_FilenamesBuild(individual_gsa_sanctions_lBaseTemplate, pversion);  

	export state_license_types_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_state_license_types::built';
	export state_license_types_lBaseTemplate	     :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_state_license_types::@version@';
	export state_license_types_lKeyTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_state_license_types::@version@';	
	export state_license_types_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_state_license_types' ;
	export state_license_types_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_state_license_types::history';
	export state_license_types_Base		             := tools.mod_FilenamesBuild(state_license_types_lBaseTemplate, pversion);  

  export individual_specialty_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_specialty::built';
	export individual_specialty_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_specialty::@version@';
	export individual_specialty_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_specialty::@version@';	
	export individual_specialty_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_specialty' ;
	export individual_specialty_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_specialty::history';
	export individual_specialty_Base		            := tools.mod_FilenamesBuild(individual_specialty_lBaseTemplate, pversion);  

  export individual_address_phones_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_address_phones::built';
	export individual_address_phones_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_address_phones::@version@';
	export individual_address_phones_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_address_phones::@version@';	
	export individual_address_phones_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_address_phones' ;
	export individual_address_phones_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_address_phones::history';
	export individual_address_phones_Base		            := tools.mod_FilenamesBuild(individual_address_phones_lBaseTemplate, pversion);  

  export individual_address_faxes_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_address_faxes::built';
	export individual_address_faxes_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_address_faxes::@version@';
	export individual_address_faxes_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_address_faxes::@version@';	
	export individual_address_faxes_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_address_faxes' ;
	export individual_address_faxes_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_address_faxes::history';
	export individual_address_faxes_Base		            := tools.mod_FilenamesBuild(individual_address_faxes_lBaseTemplate, pversion);  

  export individual_education_lBaseTemplate_built := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_education::built';
	export individual_education_lBaseTemplate	      := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_education::@version@';
	export individual_education_lKeyTemplate	      := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_education::@version@';	
	export individual_education_lInputTemplate      := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_education' ;
	export individual_education_lInputHistTemplate  := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_education::history';
	export individual_education_Base		            := tools.mod_FilenamesBuild(individual_education_lBaseTemplate, pversion);  

  export individual_certifications_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_certifications::built';
	export individual_certifications_lBaseTemplate	      := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_certifications::@version@';
	export individual_certifications_lKeyTemplate	        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_certifications::@version@';	
	export individual_certifications_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_certifications' ;
	export individual_certifications_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_certifications::history';
	export individual_certifications_Base		              := tools.mod_FilenamesBuild(individual_certifications_lBaseTemplate, pversion);  

  export individual_covered_recipients_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_covered_recipients::built';
	export individual_covered_recipients_lBaseTemplate	      := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_covered_recipients::@version@';
	export individual_covered_recipients_lKeyTemplate	        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_covered_recipients::@version@';	
	export individual_covered_recipients_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_covered_recipients' ;
	export individual_covered_recipients_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_covered_recipients::history';
	export individual_covered_recipients_Base		              := tools.mod_FilenamesBuild(individual_covered_recipients_lBaseTemplate, pversion);  

  export individual_languages_lBaseTemplate_built	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_individual_languages::built';
	export individual_languages_lBaseTemplate	     	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_individual_languages::@version@';
	export individual_languages_lKeyTemplate	      := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_individual_languages::@version@';	
	export individual_languages_lInputTemplate      := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_languages' ;
	export individual_languages_lInputHistTemplate  := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_individual_languages::history';
	export individual_languages_Base		            := tools.mod_FilenamesBuild(individual_languages_lBaseTemplate, pversion);  

  export piid_migration_lBaseTemplate_built	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::hms_piid_migration::built';
	export piid_migration_lBaseTemplate	     	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_piid_migration::@version@';
	export piid_migration_lKeyTemplate	      := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_piid_migration::@version@';	
	export piid_migration_lInputTemplate      := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_piid_migration' ;
	export piid_migration_lInputHistTemplate  := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_piid_migration::history';
	export piid_migration_Base		            := tools.mod_FilenamesBuild(piid_migration_lBaseTemplate, pversion);  

end;
