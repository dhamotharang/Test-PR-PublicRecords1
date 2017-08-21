IMPORT versioncontrol,tools,HMS_CSR;

EXPORT Filenames(string pversion = '', boolean pUseProd = false) := module

	EXPORT address_lBaseTemplate_built				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_address::built';
	EXPORT address_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_address::@version@';
	EXPORT address_lKeyTemplate	  						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_address::@version@';	
	
	EXPORT address_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_address_' + pversion;
	EXPORT address_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_address::history';
	EXPORT address_Base												:= tools.mod_FilenamesBuild(address_lBaseTemplate, pversion);
	
	EXPORT csr_lBaseTemplate_built						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_csr::built';
	EXPORT csr_lBaseTemplate									:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_csr::@version@';
	EXPORT csr_lKeyTemplate	  								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_csr::@version@';
	
	EXPORT csr_lInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_csr_' + pversion;
	EXPORT csr_lInputHistTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_csr::history';
	EXPORT csr_Base														:= tools.mod_FilenamesBuild(csr_lBaseTemplate, pversion);
	
	EXPORT dea_lBaseTemplate_built						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_dea::built';
	EXPORT dea_lBaseTemplate									:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_dea::@version@';
	EXPORT dea_lKeyTemplate	  								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_dea::@version@';	
	
	EXPORT dea_lInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_dea_' + pversion;
	EXPORT dea_lInputHistTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_dea::history';
	EXPORT dea_Base														:= tools.mod_FilenamesBuild(dea_lBaseTemplate, pversion);
	
	EXPORT disciplinaryact_lBaseTemplate_built:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_disciplinaryact::built';
	EXPORT disciplinaryact_lBaseTemplate			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_disciplinaryact::@version@';
	EXPORT disciplinaryact_lKeyTemplate	  		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_disciplinaryact::@version@';
	
	EXPORT disciplinaryact_lInputTemplate 		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_disciplinaryact_' + pversion;
	EXPORT disciplinaryact_lInputHistTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_disciplinaryact::history';
	EXPORT disciplinaryact_Base								:= tools.mod_FilenamesBuild(disciplinaryact_lBaseTemplate, pversion);
	
	EXPORT education_lBaseTemplate_built			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_education::built';
	EXPORT education_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_education::@version@';
	EXPORT education_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_education::@version@';
	
	EXPORT education_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_education_' + pversion;
	EXPORT education_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_education::history';
	EXPORT education_Base											:= tools.mod_FilenamesBuild(education_lBaseTemplate, pversion);
	
	EXPORT entity_lBaseTemplate_built					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_entity::built';
	EXPORT entity_lBaseTemplate								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_entity::@version@';
	EXPORT entity_lKeyTemplate	  						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_entity::@version@';
		
	EXPORT entity_lInputTemplate 							:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_entity_' + pversion;
	EXPORT entity_lInputHistTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_entity::history';
	EXPORT entity_Base												:= tools.mod_FilenamesBuild(entity_lBaseTemplate, pversion);
	
	EXPORT language_lBaseTemplate_built				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_language::built';
	EXPORT language_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_language::@version@';
	EXPORT language_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_language::@version@';
	

	EXPORT language_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_language_' + pversion;
	EXPORT language_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_language::history';
	EXPORT language_Base											:= tools.mod_FilenamesBuild(language_lBaseTemplate, pversion);
	
	EXPORT license_lBaseTemplate_built				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_license::built';
	EXPORT license_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_license::@version@';
	EXPORT license_lKeyTemplate	  						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_license::@version@';

	
	EXPORT license_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_license_' + pversion;
	EXPORT license_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_license::history';
	EXPORT license_Base												:= tools.mod_FilenamesBuild(license_lBaseTemplate, pversion);
	
	EXPORT npi_lBaseTemplate_built						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_npi::built';
	EXPORT npi_lBaseTemplate									:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_npi::@version@';
	EXPORT npi_lKeyTemplate	  								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_npi::@version@';
	

	EXPORT npi_lInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_npi_' + pversion;
	EXPORT npi_lInputHistTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_npi::history';
	EXPORT npi_Base														:= tools.mod_FilenamesBuild(npi_lBaseTemplate, pversion);
	
	EXPORT phone_lBaseTemplate_built					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_phone::built';
	EXPORT phone_lBaseTemplate								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_phone::@version@';
	EXPORT phone_lKeyTemplate	  							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_phone::@version@';

	
	EXPORT phone_lInputTemplate 							:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_phone_' + pversion;
	EXPORT phone_lInputHistTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_phone::history';
	EXPORT phone_Base													:= tools.mod_FilenamesBuild(phone_lBaseTemplate, pversion);
	
	EXPORT specialty_lBaseTemplate_built			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_specialty::built';
	EXPORT specialty_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_specialty::@version@';
	EXPORT specialty_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_specialty::@version@';
	
	
	EXPORT specialty_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_specialty_' + pversion;
	EXPORT specialty_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_specialty::history';
	EXPORT specialty_Base											:= tools.mod_FilenamesBuild(specialty_lBaseTemplate, pversion);
	
	EXPORT medicaid_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_medicaid::built';
	EXPORT medicaid_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_medicaid::@version@';
	EXPORT medicaid_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::medicaid::@version@';
	
	EXPORT medicaid_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hms_medicaid_' + pversion;
	EXPORT medicaid_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hms_medicaid::history';
	EXPORT medicaid_Base		  								:= tools.mod_FilenamesBuild(medicaid_lBaseTemplate, pversion);
  
	EXPORT taxonomy_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_taxonomy::built';
	EXPORT taxonomy_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_taxonomy::@version@';
	EXPORT taxonomy_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::taxonomy::@version@';
	
	EXPORT taxonomy_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hms_taxonomy_' + pversion;
	EXPORT taxonomy_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hms_taxonomy::history';
	EXPORT taxonomy_Base		  								:= tools.mod_FilenamesBuild(taxonomy_lBaseTemplate, pversion);

	EXPORT csrcredential_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_csrcredential::built';
	EXPORT csrcredential_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_csrcredential::@version@';
	EXPORT csrcredential_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::csrcredential::@version@';
	
	EXPORT csrcredential_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hms_csrcredential_' + pversion;
	EXPORT csrcredential_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hms_csrcredential::history';
	EXPORT csrcredential_Base		  								:= tools.mod_FilenamesBuild(csrcredential_lBaseTemplate, pversion);
  
	EXPORT stliclookup_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_stliclookup_' + pversion;
	EXPORT stliclookup_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_stliclookup::history';

	// EXPORT dAll_filenames := csrcredential_Base.dAll_filenames;





end;
