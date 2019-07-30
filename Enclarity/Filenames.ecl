import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module
  export collapse_lBaseTemplate_built				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::collapse::built';
	export collapse_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::collapse::@version@';
	export collapse_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::collapse::@version@';		
	export collapse_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::collapse' ;
	export collapse_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::collapse::history';
	export collapse_Base		  								:= tools.mod_FilenamesBuild(collapse_lBaseTemplate, pversion);
  
  export split_lBaseTemplate_built					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::split::built';
	export split_lBaseTemplate								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::split::@version@';
	export split_lKeyTemplate	  							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::split::@version@';		
	export split_lInputTemplate 							:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::split' ;
	export split_lInputHistTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::split::history';
	export split_Base		  										:= tools.mod_FilenamesBuild(split_lBaseTemplate, pversion);
  
  export drop_lBaseTemplate_built						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::drop::built';
	export drop_lBaseTemplate									:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::drop::@version@';
	export drop_lKeyTemplate	  							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::drop::@version@';		
	export drop_lInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::drop' ;
	export drop_lInputHistTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::drop::history';
	export drop_Base		  										:= tools.mod_FilenamesBuild(drop_lBaseTemplate, pversion);
  
  export facility_lBaseTemplate_built				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::facility::built';
	export facility_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::facility::@version@';
	export facility_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::facility::@version@';		
	export facility_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::facility' ;
	export facility_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::facility::history';
	export facility_Base		  								:= tools.mod_FilenamesBuild(facility_lBaseTemplate, pversion);
  
	export individual_lBaseTemplate_built 		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::individual::built';
	export individual_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::individual::@version@';
	export individual_lKeyTemplate	  				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::individual::@version@';		
	export individual_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::individual';
	export individual_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::individual::history';
	export individual_Base		  							:= tools.mod_FilenamesBuild(individual_lBaseTemplate, pversion);
	
	export associate_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::associate::built';
	export associate_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::associate::@version@';
	export associate_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::associate::@version@';		
	export associate_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::associate';
	export associate_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::associate::history';
	export associate_Base		  								:= tools.mod_FilenamesBuild(associate_lBaseTemplate, pversion);

  export address_lBaseTemplate_built 				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::address::built';
	export address_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::address::@version@';
	export address_lKeyTemplate	  						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::address::@version@';		
	export address_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::address';
	export address_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::address::history';
	export address_Base		  									:= tools.mod_FilenamesBuild(address_lBaseTemplate, pversion);

  export dea_lBaseTemplate_built 						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::dea::built';
	export dea_lBaseTemplate									:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::dea::@version@';
	export dea_lKeyTemplate	  								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::dea::@version@';		
	export dea_lInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::dea';
	export dea_lInputHistTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::dea::history';
	export dea_Base		  											:= tools.mod_FilenamesBuild(dea_lBaseTemplate, pversion);

  export license_lBaseTemplate_built 				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::license::built';
	export license_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::license::@version@';
	export license_lKeyTemplate	  						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::license::@version@';		
	export license_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::license';
	export license_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::license::history';
	export license_Base		  									:= tools.mod_FilenamesBuild(license_lBaseTemplate, pversion);
	
  export taxonomy_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::taxonomy::built';
	export taxonomy_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::taxonomy::@version@';
	export taxonomy_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::taxonomy::@version@';		
	export taxonomy_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::taxonomy';
	export taxonomy_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::taxonomy::history';
	export taxonomy_Base		  								:= tools.mod_FilenamesBuild(taxonomy_lBaseTemplate, pversion);

  export npi_lBaseTemplate_built 						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::npi::built';
	export npi_lBaseTemplate									:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::npi::@version@';
	export npi_lKeyTemplate	  								:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::npi::@version@';		
	export npi_lInputTemplate 								:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::npi';
	export npi_lInputHistTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::npi::history';
	export npi_Base		  											:= tools.mod_FilenamesBuild(npi_lBaseTemplate, pversion);
	
	export medschool_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::medschool::built';
	export medschool_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::medschool::@version@';
	export medschool_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::medschool::@version@';		
	export medschool_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::medschool';
	export medschool_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::medschool::history';
	export medschool_Base		  								:= tools.mod_FilenamesBuild(medschool_lBaseTemplate, pversion);

	export tax_codes_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::tax_codes::built';
	export tax_codes_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::tax_codes::@version@';
	export tax_codes_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::tax_codes::@version@';		
	export tax_codes_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::tax_codes';
	export tax_codes_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::tax_codes::history';
	export tax_codes_Base		  								:= tools.mod_FilenamesBuild(tax_codes_lBaseTemplate, pversion);

	export prov_ssn_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::provider_ssn::built';
	export prov_ssn_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::provider_ssn::@version@';
	export prov_ssn_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::provider_ssn::@version@';		
	export prov_ssn_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::provider_ssn';
	export prov_ssn_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::provider_ssn::history';
	export prov_ssn_Base		  								:= tools.mod_FilenamesBuild(prov_ssn_lBaseTemplate, pversion);
	
	export specialty_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::specialty::built';
	export specialty_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::specialty::@version@';
	export specialty_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::specialty::@version@';		
	export specialty_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::specialty';
	export specialty_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::specialty::history';
	export specialty_Base		  								:= tools.mod_FilenamesBuild(specialty_lBaseTemplate, pversion);

	export sanc_prov_type_lBaseTemplate_built := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::sanc_prov_type::built';
	export sanc_prov_type_lBaseTemplate				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::sanc_prov_type::@version@';
	export sanc_prov_type_lKeyTemplate	  		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::sanc_prov_type::@version@';		
	export sanc_prov_type_lInputTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::sanc_prov_type';
	export sanc_prov_type_lInputHistTemplate 	:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::sanc_prov_type::history';
	export sanc_prov_type_Base		  					:= tools.mod_FilenamesBuild(sanc_prov_type_lBaseTemplate, pversion);

	export sanc_codes_lBaseTemplate_built 		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::sanc_codes::built';
	export sanc_codes_lBaseTemplate						:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::sanc_codes::@version@';
	export sanc_codes_lKeyTemplate	  				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::sanc_codes::@version@';		
	export sanc_codes_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::sanc_codes';
	export sanc_codes_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::sanc_codes::history';
	export sanc_codes_Base		  							:= tools.mod_FilenamesBuild(sanc_codes_lBaseTemplate, pversion);

	export dea_BAcodes_lBaseTemplate_built 		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::dea_BAcodes::built';
	export dea_BAcodes_lBaseTemplate					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::dea_BAcodes::@version@';
	export dea_BAcodes_lKeyTemplate	  				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::dea_BAcodes::@version@';		
	export dea_BAcodes_lInputTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::dea_BAcodes';
	export dea_BAcodes_lInputHistTemplate 		:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::dea_BAcodes::history';
	export dea_BAcodes_Base		  							:= tools.mod_FilenamesBuild(dea_BAcodes_lBaseTemplate, pversion);
	
	export prov_birthdate_lBaseTemplate_built	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::provider_birthdate::built';
	export prov_birthdate_lBaseTemplate				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::provider_birthdate::@version@';
	export prov_birthdate_lKeyTemplate	  		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::provider_birthdate::@version@';		
	export prov_birthdate_lInputTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::provider_birthdate';
	export prov_birthdate_lInputHistTemplate 	:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::provider_birthdate::history';
	export prov_birthdate_Base		  					:= tools.mod_FilenamesBuild(prov_birthdate_lBaseTemplate, pversion);

	export sanction_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::sanction::built';
	export sanction_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::sanction::@version@';
	export sanction_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::sanction::@version@';		
	export sanction_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::sanction';
	export sanction_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::sanction::history';
	export sanction_Base		  								:= tools.mod_FilenamesBuild(sanction_lBaseTemplate, pversion);

	export gk_to_provID_lBaseTemplate					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::gk_to_provID::@version@';
	export gk_to_provID_Base									:= tools.mod_FilenamesBuild(gk_to_provID_lBaseTemplate, pversion);
	
	export individual_exceptions_lBaseTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::individual_exceptions::@version@';
	export individual_exceptions								:= tools.mod_FilenamesBuild(individual_exceptions_lBaseTemplate, pversion);
	
end;

// inventory of files from Enclarity:
//	 1 -	facility
//	 2 -	individuals
//	 3 - assoc file
//	 4 - address file
//	 5 - dea file
//	 6 - license file
//	 7 - npi file
//	 8 - idv board sanction file
//	 9 - specialty file
//	10 - med school file
//	11 - taxonomy 
//	12 - board santion decodes
//	13 - board sanction provider types
//	14 - taxonomy codes
//	15 - dea ba definitions - one time - won't be receiving with updates
//	16 - ssn file
//	17 - birthdate

