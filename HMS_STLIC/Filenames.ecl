IMPORT versioncontrol,tools;

EXPORT Filenames(string pversion = '', boolean pUseProd = false) := module

	EXPORT address_lBaseTemplate_built				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_address::built';
	EXPORT address_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_address::@version@';
	EXPORT address_lKeyTemplate	  						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_address::@version@';	
	
	EXPORT address_SlInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_address';

	EXPORT address_new_lInputTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_address_' + pversion;	
	EXPORT address_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_address_' + pversion;
	EXPORT address_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_address::history';
	EXPORT address_Base												:= tools.mod_FilenamesBuild(address_lBaseTemplate, pversion);
	
	EXPORT address_SConlInputTemplate					:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::hms_stl_consolidated';
	EXPORT address_ConlInputTemplate					:= _Dataset(pUseProd).thor_cluster_files + 'in::'  + _Dataset().name + '::hms_stl_consolidated::hms_address_' + pVersion;
		
	EXPORT csr_lBaseTemplate_built						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_csr::built';
	EXPORT csr_lBaseTemplate									:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_csr::@version@';
	EXPORT csr_lKeyTemplate	  								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_csr::@version@';
	
	EXPORT csr_SlInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_csr';

	EXPORT csr_new_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_csr_' + pversion;	
	EXPORT csr_lInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_csr_' + pversion;
	EXPORT csr_lInputHistTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_csr::history';
	EXPORT csr_Base														:= tools.mod_FilenamesBuild(csr_lBaseTemplate, pversion);
	
	EXPORT dea_lBaseTemplate_built						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_dea::built';
	EXPORT dea_lBaseTemplate									:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_dea::@version@';
	EXPORT dea_lKeyTemplate	  								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_dea::@version@';	
	
	EXPORT dea_SlInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_dea';
	
	EXPORT dea_new_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_dea_' + pversion;
	EXPORT dea_lInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_dea_' + pversion;
	EXPORT dea_lInputHistTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_dea::history';
	EXPORT dea_Base														:= tools.mod_FilenamesBuild(dea_lBaseTemplate, pversion);
	
	EXPORT disciplinaryact_lBaseTemplate_built:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_disciplinaryact::built';
	EXPORT disciplinaryact_lBaseTemplate			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_disciplinaryact::@version@';
	EXPORT disciplinaryact_lKeyTemplate	  		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_disciplinaryact::@version@';
	
	EXPORT disciplinaryact_SlInputTemplate 		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_disciplinaryact';
		
	EXPORT disciplinaryact_new_lInputTemplate := _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_disciplinaryact_' + pversion;	
	EXPORT disciplinaryact_lInputTemplate 		:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_disciplinaryact_' + pversion;
	EXPORT disciplinaryact_lInputHistTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_disciplinaryact::history';
	EXPORT disciplinaryact_Base								:= tools.mod_FilenamesBuild(disciplinaryact_lBaseTemplate, pversion);
	
	EXPORT education_lBaseTemplate_built			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_education::built';
	EXPORT education_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_education::@version@';
	EXPORT education_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_education::@version@';
	
	EXPORT education_SlInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_education';
	
	EXPORT education_new_lInputTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_education_' + pversion;	
	EXPORT education_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_education_' + pversion;
	EXPORT education_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_education::history';
	EXPORT education_Base											:= tools.mod_FilenamesBuild(education_lBaseTemplate, pversion);
	
	EXPORT entity_lBaseTemplate_built					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_entity::built';
	EXPORT entity_lBaseTemplate								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_entity::@version@';
	EXPORT entity_lKeyTemplate	  						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_entity::@version@';
		
	EXPORT entity_SlInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_entity';

	EXPORT entity_new_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_entity_' + pversion;	
	EXPORT entity_lInputTemplate 							:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_entity_' + pversion;
	EXPORT entity_lInputHistTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_entity::history';
	EXPORT entity_Base												:= tools.mod_FilenamesBuild(entity_lBaseTemplate, pversion);
	
	EXPORT language_lBaseTemplate_built				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_language::built';
	EXPORT language_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_language::@version@';
	EXPORT language_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_language::@version@';
	
	EXPORT language_SlInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_language';

	EXPORT language_new_lInputTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_language_' + pversion;	
	EXPORT language_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_language_' + pversion;
	EXPORT language_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_language::history';
	EXPORT language_Base											:= tools.mod_FilenamesBuild(language_lBaseTemplate, pversion);
	
	EXPORT license_lBaseTemplate_built				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_license::built';
	EXPORT license_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_license::@version@';
	EXPORT license_lKeyTemplate	  						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_license::@version@';

	EXPORT license_SlInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_license';
	
	EXPORT license_new_lInputTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_license_' + pversion;
	EXPORT license_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_license_' + pversion;
	EXPORT license_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_license::history';
	EXPORT license_Base												:= tools.mod_FilenamesBuild(license_lBaseTemplate, pversion);
	
	EXPORT npi_lBaseTemplate_built						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_npi::built';
	EXPORT npi_lBaseTemplate									:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_npi::@version@';
	EXPORT npi_lKeyTemplate	  								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_npi::@version@';
	
	EXPORT npi_SlInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_npi';
	
	EXPORT npi_new_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_npi_' + pversion;
	EXPORT npi_lInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_npi_' + pversion;
	EXPORT npi_lInputHistTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_npi::history';
	EXPORT npi_Base														:= tools.mod_FilenamesBuild(npi_lBaseTemplate, pversion);
	
	EXPORT phone_lBaseTemplate_built					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_phone::built';
	EXPORT phone_lBaseTemplate								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_phone::@version@';
	EXPORT phone_lKeyTemplate	  							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_phone::@version@';

	EXPORT phone_SlInputTemplate 							:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_phone';
	
	EXPORT phone_new_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_phone_' + pversion;
	EXPORT phone_lInputTemplate 							:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_phone_' + pversion;
	EXPORT phone_lInputHistTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_phone::history';
	EXPORT phone_Base													:= tools.mod_FilenamesBuild(phone_lBaseTemplate, pversion);
	
	EXPORT specialty_lBaseTemplate_built			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_specialty::built';
	EXPORT specialty_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_specialty::@version@';
	EXPORT specialty_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_specialty::@version@';
	
	EXPORT specialty_SlInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_specialty';
	
	EXPORT specialty_new_lInputTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_specialty_' + pversion;	
	EXPORT specialty_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_specialty_' + pversion;
	EXPORT specialty_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_specialty::history';
	EXPORT specialty_Base											:= tools.mod_FilenamesBuild(specialty_lBaseTemplate, pversion);
	
	EXPORT statelicense_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_statelicense::built';
	EXPORT statelicense_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_statelicense::@version@';
	EXPORT statelicense_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_statelicense::@version@';	
	
	EXPORT statelicense_SlInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hms_statelicense';

	EXPORT statelicense_new_lInputTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::'   + HMS_STLIC._Dataset().name + '::hms_statelicense_' + pversion;	
	EXPORT statelicense_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hms_statelicense_' + pversion;
	EXPORT statelicense_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hms_statelicense::history';
	EXPORT statelicense_Base		  								:= tools.mod_FilenamesBuild(statelicense_lBaseTemplate, pversion);
 
 	EXPORT stliclookup_new_lInputTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'temp_in::' + HMS_STLIC._Dataset().name + '::hms_stliclookup_' + pversion;		
	EXPORT stliclookup_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_stliclookup_' + pversion;
	EXPORT stliclookup_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::hms_stliclookup::history';
	
	/*HMS replacement for AMS*/
	EXPORT stlicrollup_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hms_stlicrollup::built';
	EXPORT stlicrollup_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hms_stlicrollup::@version@';
	EXPORT stlicrollup_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hms_stlicrollup::@version@';
	EXPORT stlicrollup_Base		  				        := tools.mod_FilenamesBuild(stlicrollup_lBaseTemplate, pversion);
	/*HMS replacement for AMS*/

	EXPORT dAll_filenames := statelicense_Base.dAll_filenames;





end;
