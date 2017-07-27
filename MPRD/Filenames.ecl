import versioncontrol,tools,MPRD;

export Filenames(string pversion = '', boolean pUseProd = false) := module
  export individual_lBaseTemplate_built  									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::individual::built';
	export individual_lBaseTemplate	       									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::individual::@version@';
	export individual_lKeyTemplate	       									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::individual::@version@';	
	export individual_lInputTemplate       									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::individual' ;
	export individual_lInputHistTemplate   									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::individual::history';
	export individual_Base		             									:= tools.mod_FilenamesBuild(individual_lBaseTemplate, pversion);
	export individual_Input 														  	:= versioncontrol.mInputFilenameVersions(individual_lInputTemplate);

	export facility_lBaseTemplate_built	   									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::facility::built';
	export facility_lBaseTemplate					 									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::facility::@version@';
	export facility_lKeyTemplate	  			 									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::facility::@version@';		
	export facility_lInputTemplate 				 									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::facility' ;
	export facility_lInputHistTemplate 		 									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::facility::history';
	export facility_Base		  						 									:= tools.mod_FilenamesBuild(facility_lBaseTemplate, pversion);
	export facility_Input																		:= versioncontrol.mInputFileNameVersions(facility_lInputTemplate);

	export dea_xref_lBaseTemplate_built    									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::dea_xref::built';
	export dea_xref_lBaseTemplate	         									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::dea_xref::@version@';
	export dea_xref_lKeyTemplate	         									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::dea_xref::@version@';	
	export dea_xref_lInputTemplate         									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::dea_xref' ;
	export dea_xref_lInputHistTemplate     									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::dea_xref::history';
	export dea_xref_Base		               									:= tools.mod_FilenamesBuild(dea_xref_lBaseTemplate, pversion);
	export dea_xref_Input																		:= versioncontrol.mInputFileNameVersions(dea_xref_lInputTemplate);
	
	export npi_tin_xref_lBaseTemplate_built  								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::npi_tin_xref::built';
	export npi_tin_xref_lBaseTemplate	       								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::npi_tin_xref::@version@';
	export npi_tin_xref_lKeyTemplate	       								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::npi_tin_xref::@version@';	
	export npi_tin_xref_lInputTemplate       								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::npi_tin_xref' ;
	export npi_tin_xref_lInputHistTemplate   								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::npi_tin_xref::history';
	export npi_tin_xref_Base		             								:= tools.mod_FilenamesBuild(npi_tin_xref_lBaseTemplate, pversion);
	export npi_tin_xref_Input																:= versioncontrol.mInputFileNameVersions(npi_tin_xref_lInputTemplate);

	// export address_name_xref_lBaseTemplate_built 						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::address_name_xref::built';
	// export address_name_xref_lBaseTemplate	     						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::address_name_xref::@version@';
	// export address_name_xref_lKeyTemplate	       						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::address_name_xref::@version@';	
	// export address_name_xref_lInputTemplate      						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::address_name_xref' ;
	// export address_name_xref_lInputHistTemplate  						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::address_name_xref::history';
	// export address_name_xref_Base		             						:= tools.mod_FilenamesBuild(address_name_xref_lBaseTemplate, pversion);
	// export address_name_xref_Input													:= versioncontrol.mInputFileNameVersions(address_name_xref_lInputTemplate);

	export facility_name_xref_lBaseTemplate_built  					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::facility_name_xref::built';
	export facility_name_xref_lBaseTemplate	       					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::facility_name_xref::@version@';
	export facility_name_xref_lKeyTemplate	      	 				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::facility_name_xref::@version@';	
	export facility_name_xref_lInputTemplate       					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::facility_name_xref' ;
	export facility_name_xref_lInputHistTemplate   					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::facility_name_xref::history';
	export facility_name_xref_Base		             					:= tools.mod_FilenamesBuild(facility_name_xref_lBaseTemplate, pversion);
	export facility_name_xref_Input													:= versioncontrol.mInputFileNameVersions(facility_name_xref_lInputTemplate);

	export basc_cp_lBaseTemplate_built  										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::basc_cp::built';
	export basc_cp_lBaseTemplate	      										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::basc_cp::@version@';
	export basc_cp_lKeyTemplate	        										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::basc_cp::@version@';	
	export basc_cp_lInputTemplate       										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::basc_cp' ;
	export basc_cp_lInputHistTemplate   										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::basc_cp::history';
	export basc_cp_Base		              										:= tools.mod_FilenamesBuild(basc_cp_lBaseTemplate, pversion);
	export basc_cp_Input																		:= versioncontrol.mInputFileNameVersions(basc_cp_lInputTemplate);

	export basc_claims_lBaseTemplate_built  								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::basc_claims::built';
	export basc_claims_lBaseTemplate	      								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::basc_claims::@version@';
	export basc_claims_lKeyTemplate	        								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::basc_claims::@version@';	
	export basc_claims_lInputTemplate       								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::basc_claims' ;
	export basc_claims_lInputHistTemplate   								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::basc_claims::history';
	export basc_claims_Base		              								:= tools.mod_FilenamesBuild(basc_claims_lBaseTemplate, pversion);
	export basc_claims_Input																:= versioncontrol.mInputFileNameVersions(basc_claims_lInputTemplate);

	export npi_extension_lBaseTemplate_built  							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::npi_extension::built';
	export npi_extension_lBaseTemplate	      							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::npi_extension::@version@';
	export npi_extension_lKeyTemplate	        							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::npi_extension::@version@';	
	export npi_extension_lInputTemplate       							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::npi_extension' ;
	export npi_extension_lInputHistTemplate   							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::npi_extension::history';
	export npi_extension_Base		              							:= tools.mod_FilenamesBuild(npi_extension_lBaseTemplate, pversion);
	export npi_extension_Input															:= versioncontrol.mInputFileNameVersions(npi_extension_lInputTemplate);

	export npi_extension_facility_lBaseTemplate_built  			:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::npi_extension_facility::built';
	export npi_extension_facility_lBaseTemplate	       			:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::npi_extension_facility::@version@';
	export npi_extension_facility_lKeyTemplate	       			:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::npi_extension_facility::@version@';	
	export npi_extension_facility_lInputTemplate       			:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::npi_extension_facility' ;
	export npi_extension_facility_lInputHistTemplate   			:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::npi_extension_facility::history';
	export npi_extension_facility_Base		             			:= tools.mod_FilenamesBuild(npi_extension_facility_lBaseTemplate, pversion);
	export npi_extension_facility_Input											:= versioncontrol.mInputFileNameVersions(npi_extension_facility_lInputTemplate);

	export claims_addr_master_lBaseTemplate_built  					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::claims_addr_master::built';
	export claims_addr_master_lBaseTemplate	       					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::claims_addr_master::@version@';
	export claims_addr_master_lKeyTemplate	       					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::claims_addr_master::@version@';	
	export claims_addr_master_lInputTemplate       					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::claims_addr_master' ;
	export claims_addr_master_lInputHistTemplate   					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::claims_addr_master::history';
	export claims_addr_master_Base		             					:= tools.mod_FilenamesBuild(claims_addr_master_lBaseTemplate, pversion);
	export claims_addr_master_input 												:= versioncontrol.mInputFileNameVersions(claims_addr_master_lInputTemplate);

  export taxonomy_equiv_lBaseTemplate_built   						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::taxonomy_equiv::built';
  export taxonomy_equiv_lBaseTemplate       	  					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::taxonomy_equiv::@version@';
  export taxonomy_equiv_lKeyTemplate          						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::taxonomy_equiv::@version@';      
  export taxonomy_equiv_lInputTemplate        						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::taxonomy_equiv' ;
  export taxonomy_equiv_lInputHistTemplate    						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::taxonomy_equiv::history';
  export taxonomy_equiv_Base                  						:= tools.mod_FilenamesBuild(taxonomy_equiv_lBaseTemplate, pversion);
	export taxonomy_equiv_input 														:= versioncontrol.mInputFileNameVersions(taxonomy_equiv_lInputTemplate);

  export claims_by_month_lBaseTemplate_built  						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::claims_by_month::built';
  export claims_by_month_lBaseTemplate        						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::claims_by_month::@version@';
  export claims_by_month_lKeyTemplate         						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::claims_by_month::@version@';      
  export claims_by_month_lInputTemplate       						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::claims_by_month' ;
  export claims_by_month_lInputHistTemplate   						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::claims_by_month::history';
  export claims_by_month_Base                 						:= tools.mod_FilenamesBuild(claims_by_month_lBaseTemplate, pversion);
	export claims_by_month_input 														:= versioncontrol.mInputFileNameVersions(claims_by_month_lInputTemplate);

  export basc_deceased_lBaseTemplate_built 		 						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::basc_deceased::built';
  export basc_deceased_lBaseTemplate        							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::basc_deceased::@version@';
  export basc_deceased_lKeyTemplate         							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::basc_deceased::@version@';      
  export basc_deceased_lInputTemplate       							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::basc_deceased' ;
  export basc_deceased_lInputHistTemplate   							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::basc_deceased::history';
  export basc_deceased_Base                 							:= tools.mod_FilenamesBuild(basc_deceased_lBaseTemplate, pversion);
	export basc_deceased_input 															:= versioncontrol.mInputFileNameVersions(basc_deceased_lInputTemplate);

  export basc_addr_lBaseTemplate_built  									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::basc_addr::built';
  export basc_addr_lBaseTemplate        									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::basc_addr::@version@';
  export bbasc_addr_lKeyTemplate        									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::basc_addr::@version@';      
  export basc_addr_lInputTemplate       									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::basc_addr' ;
  export basc_addr_lInputHistTemplate   									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::basc_addr::history';
  export basc_addr_Base                 									:= tools.mod_FilenamesBuild(basc_addr_lBaseTemplate, pversion);
	export basc_addr_input 																	:= versioncontrol.mInputFileNameVersions(basc_addr_lInputTemplate);

  export client_data_lBaseTemplate_built  								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::client_data::built';
  export client_data_lBaseTemplate        								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::client_data::@version@';
  export client_data_lKeyTemplate       	  							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::client_data::@version@';      
  export client_data_lInputTemplate       								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::client_data' ;
  export client_data_lInputHistTemplate   								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::client_data::history';
  export client_data_Base                 								:= tools.mod_FilenamesBuild(client_data_lBaseTemplate, pversion);
	export client_data_input 																:= versioncontrol.mInputFileNameVersions(client_data_lInputTemplate);

  export office_attributes_lBaseTemplate_built 		 				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::office_attributes::built';
  export office_attributes_lBaseTemplate        					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::office_attributes::@version@';
  export office_attributes_lKeyTemplate         					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::office_attributes::@version@';      
  export office_attributes_lInputTemplate       					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::office_attributes' ;
  export office_attributes_lInputHistTemplate   					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::office_attributes::history';
  export office_attributes_Base                 					:= tools.mod_FilenamesBuild(office_attributes_lBaseTemplate, pversion);
	export office_attributes_input 													:= versioncontrol.mInputFileNameVersions(office_attributes_lInputTemplate);
				
	export office_attributes_facility_lBaseTemplate_built 	:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::office_attributes_facility::built';
  export office_attributes_facility_lBaseTemplate       	:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::office_attributes_facility::@version@';
  export office_attributes_facility_lKeyTemplate     	  	:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::office_attributes_facility::@version@';      
  export office_attributes_facility_lInputTemplate      	:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::office_attributes_facility' ;
  export office_attributes_facility_lInputHistTemplate  	:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::office_attributes_facility::history';
  export office_attributes_facility_Base                	:= tools.mod_FilenamesBuild(office_attributes_facility_lBaseTemplate, pversion);
	export office_attributes_facility_input 								:= versioncontrol.mInputFileNameVersions(office_attributes_facility_lInputTemplate);
		
	export std_terms_lu_lBaseTemplate_built  								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::std_terms_lu::built';
  export std_terms_lu_lBaseTemplate        								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::std_terms_lu::@version@';
  export std_terms_lu_lKeyTemplate         								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::std_terms_lu::@version@';      
  export std_terms_lu_lInputTemplate       								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::std_terms_lu' ;
  export std_terms_lu_lInputHistTemplate   								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::std_terms_lu::history';
	export std_terms_lu_Base                 								:= tools.mod_FilenamesBuild(std_terms_lu_lBaseTemplate, pversion);
	export std_terms_lu_input 															:= versioncontrol.mInputFileNameVersions(std_terms_lu_lInputTemplate);

  export taxonomy_full_lu_lBaseTemplate_built 	 					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::taxonomy_full_lu::built';
  export taxonomy_full_lu_lBaseTemplate        						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::taxonomy_full_lu::@version@';
  export taxonomy_full_lu_lKeyTemplate         						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::taxonomy_full_lu::@version@';      
  export taxonomy_full_lu_lInputTemplate       						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::taxonomy_full_lu ' ;
  export taxonomy_full_lu_lInputHistTemplate   						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::taxonomy_full_lu::history';
  export taxonomy_full_lu_Base                 						:= tools.mod_FilenamesBuild(taxonomy_full_lu_lBaseTemplate, pversion);
	export taxonomy_full_lu_input 													:= versioncontrol.mInputFileNameVersions(taxonomy_full_lu_lInputTemplate);

  export dir_confidence_2010_lu_lBaseTemplate_built  			:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::dir_confidence_2010_lu::built';
  export dir_confidence_2010_lu_lBaseTemplate     	   		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::dir_confidence_2010_lu::@version@';
  export dir_confidence_2010_lu_lKeyTemplate        	 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::dir_confidence_2010_lu::@version@';      
  export dir_confidence_2010_lu_lInputTemplate       			:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::dir_confidence_2010_lu' ;
  export dir_confidence_2010_lu_lInputHistTemplate  	 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::dir_confidence_2010_lu::history';
  export dir_confidence_2010_lu_Base                 			:= tools.mod_FilenamesBuild(dir_confidence_2010_lu_lBaseTemplate, pversion);
	export dir_confidence_2010_lu_input 										:= versioncontrol.mInputFileNameVersions(dir_confidence_2010_lu_lInputTemplate);

  export specialty_lu_lBaseTemplate_built  								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::specialty_lu::built';
  export specialty_lu_lBaseTemplate        								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::specialty_lu::@version@';
  export specialty_lu_lKeyTemplate         								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::specialty_lu::@version@';      
  export specialty_lu_lInputTemplate       								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::specialty_lu' ;
  export specialty_lu_lInputHistTemplate   								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::specialty_lu::history';
  export specialty_lu_Base                 								:= tools.mod_FilenamesBuild(specialty_lu_lBaseTemplate, pversion);
	export specialty_lu_input 															:= versioncontrol.mInputFileNameVersions(specialty_lu_lInputTemplate);

  export group_lu_lBaseTemplate_built  										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::group_lu::built';
  export group_lu_lBaseTemplate        										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::group_lu::@version@';
  export group_lu_lKeyTemplate         										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::group_lu::@version@';      
  export group_lu_lInputTemplate       										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::group_lu' ;
  export group_lu_lInputHistTemplate   										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::group_lu::history';
  export group_lu_Base                 										:= tools.mod_FilenamesBuild(group_lu_lBaseTemplate, pversion);
	export group_lu_input 																	:= versioncontrol.mInputFileNameVersions(group_lu_lInputTemplate);

  export hospital_lu_lBaseTemplate_built  								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::hospital_lu::built';
  export hospital_lu_lBaseTemplate        								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::hospital_lu::@version@';
  export hospital_lu_lKeyTemplate         								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::hospital_lu::@version@';      
  export hospital_lu_lInputTemplate       								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::hospital_lu';
  export hospital_lu_lInputHistTemplate   								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::hospital_lu::history';
  export hospital_lu_Base                 								:= tools.mod_FilenamesBuild(hospital_lu_lBaseTemplate, pversion);
	export hospital_lu_input 																:= versioncontrol.mInputFileNameVersions(hospital_lu_lInputTemplate);

  export lic_xref_lBaseTemplate_built  										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::lic_xref::built';
  export lic_xref_lBaseTemplate        										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::lic_xref::@version@';
  export lic_xref_lKeyTemplate         										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::lic_xref::@version@';      
  export lic_xref_lInputTemplate       										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::lic_xref';
  export lic_xref_lInputHistTemplate   										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::lic_xref::history';
  export lic_xref_Base                 										:= tools.mod_FilenamesBuild(lic_xref_lBaseTemplate, pversion);
	export lic_xref_input 																	:= versioncontrol.mInputFileNameVersions(lic_xref_lInputTemplate);
		
  export addr_name_xref_lBaseTemplate_built 	 						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::addr_name_xref::built';
  export addr_name_xref_lBaseTemplate        							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::addr_name_xref::@version@';
  export addr_name_xref_lKeyTemplate         							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::addr_name_xref::@version@';      
  export addr_name_xref_lInputTemplate       							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::addr_name_xref' ;
  export addr_name_xref_lInputHistTemplate   							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::addr_name_xref::history';
  export addr_name_xref_Base                 							:= tools.mod_FilenamesBuild(addr_name_xref_lBaseTemplate, pversion);
	export addr_name_xref_input 														:= versioncontrol.mInputFileNameVersions(addr_name_xref_lInputTemplate);

  export basc_facility_mme_lBaseTemplate_built  					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::basc_facility_mme::built';
  export basc_facility_mme_lBaseTemplate        					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::basc_facility_mme::@version@';
  export basc_facility_mme_lKeyTemplate         					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::basc_facility_mme::@version@';      
  export basc_facility_mme_lInputTemplate       					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::basc_facility_mme' ;
  export basc_facility_mme_lInputHistTemplate   					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::basc_facility_mme::history';
  export basc_facility_mme_Base                 					:= tools.mod_FilenamesBuild(basc_facility_mme_lBaseTemplate, pversion);
	export basc_facility_mme_input 													:= versioncontrol.mInputFileNameVersions(basc_facility_mme_lInputTemplate);

  export lic_filedate_lBaseTemplate_built  								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::lic_filedate::built';
  export lic_filedate_lBaseTemplate        								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::lic_filedate::@version@';
  export lic_filedate_lKeyTemplate         								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::lic_filedate::@version@';      
  export lic_filedate_lInputTemplate       								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::lic_filedate' ;
  export lic_filedate_lInputHistTemplate   								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::lic_filedate::history';
  export lic_filedate_Base                 								:= tools.mod_FilenamesBuild(lic_filedate_lBaseTemplate, pversion);
	export lic_filedate_input 															:= versioncontrol.mInputFileNameVersions(lic_filedate_lInputTemplate);

  export nanpa_lBaseTemplate_built  											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::nanpa::built';
  export nanpa_lBaseTemplate        											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::nanpa::@version@';
  export nanpa_lKeyTemplate         											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::nanpa::@version@';      
  export nanpa_lInputTemplate       											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::nanpa' ;
  export nanpa_lInputHistTemplate   											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::nanpa::history';
  export nanpa_Base                 											:= tools.mod_FilenamesBuild(nanpa_lBaseTemplate, pversion);
	export nanpa_input 																			:= versioncontrol.mInputFileNameVersions(nanpa_lInputTemplate);
		
  export best_hospital_lBaseTemplate_built  							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::best_hospital::built';
  export best_hospital_lBaseTemplate        							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::best_hospital::@version@';
  export best_hospital_lKeyTemplate         							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::best_hospital::@version@';      
  export best_hospital_lInputTemplate       							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::best_hospital' ;
  export best_hospital_lInputHistTemplate   							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::best_hospital::history';
  export best_hospital_Base                 							:= tools.mod_FilenamesBuild(best_hospital_lBaseTemplate, pversion);
	export best_hospital_input 															:= versioncontrol.mInputFileNameVersions(best_hospital_lInputTemplate);
		
	export last_name_stats_lBaseTemplate_built  						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::last_name_stats::built';
  export last_name_stats_lBaseTemplate        						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::last_name_stats::@version@';
  export last_name_stats_lKeyTemplate         						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::last_name_stats::@version@';      
  export last_name_stats_lInputTemplate       						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::last_name_stats' ;
  export last_name_stats_lInputHistTemplate   						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::last_name_stats::history';
  export last_name_stats_Base                 						:= tools.mod_FilenamesBuild(last_name_stats_lBaseTemplate, pversion);
	export last_name_stats_input 														:= versioncontrol.mInputFileNameVersions(last_name_stats_lInputTemplate);
		
	export source_confidence_lu_lBaseTemplate_built  				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::source_confidence_lu::built';
	export source_confidence_lu_lBaseTemplate        				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::source_confidence_lu::@version@';
	export source_confidence_lu_lKeyTemplate        	 			:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::source_confidence_lu ::@version@';      
	export source_confidence_lu_lInputTemplate       				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::source_confidence_lu ' ;
	export source_confidence_lu_lInputHistTemplate   				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::source_confidence_lu::history';
	export source_confidence_lu_Base                 				:= tools.mod_FilenamesBuild(source_confidence_lu_lBaseTemplate, pversion);
	export source_confidence_lu_input 											:= versioncontrol.mInputFileNameVersions(source_confidence_lu_lInputTemplate);
		
	export ignore_terms_lu_lBaseTemplate_built  						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::ignore_terms_lu::built';
	export ignore_terms_lu_lBaseTemplate        						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::ignore_terms_lu::@version@';
	export ignore_terms_lu_lKeyTemplate         						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::ignore_terms_lu::@version@';      
	export ignore_terms_lu_lInputTemplate       						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::ignore_terms_lu' ;
	export ignore_terms_lu_lInputHistTemplate   						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::ignore_terms_lu::history';
	export ignore_terms_lu_Base                 						:= tools.mod_FilenamesBuild(ignore_terms_lu_lBaseTemplate, pversion);
	export ignore_terms_lu_input 														:= versioncontrol.mInputFileNameVersions(ignore_terms_lu_lInputTemplate);
		
	export taxon_lu_lBaseTemplate_built  										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::taxon_lu::built';
	export taxon_lu_lBaseTemplate        										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::taxon_lu::@version@';
	export taxon_lu_lKeyTemplate         										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::taxon_lu ::@version@';      
	export taxon_lu_lInputTemplate       										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::taxon_lu' ;
	export taxon_lu_lInputHistTemplate   										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::taxon_lu::history';
	export taxon_lu_Base                 										:= tools.mod_FilenamesBuild(taxon_lu_lBaseTemplate, pversion);
	export taxon_lu_input 																	:= versioncontrol.mInputFileNameVersions(taxon_lu_lInputTemplate);
				
	export abbr_lu_lBaseTemplate_built  										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::abbr_lu::built';
	export abbr_lu_lBaseTemplate        										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::abbr_lu::@version@';
	export abbr_lu_lKeyTemplate         										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::abbr_lu::@version@';      
	export abbr_lu_lInputTemplate       										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::abbr_lu' ;
	export abbr_lu_lInputHistTemplate   										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::abbr_lu::history';
	export abbr_lu_Base																			:= tools.mod_FilenamesBuild(abbr_lu_lBaseTemplate, pversion);
	export abbr_lu_input 																		:= versioncontrol.mInputFileNameVersions(abbr_lu_lInputTemplate);
		
	export call_queue_bad_lBaseTemplate_built								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::call_queue_bad::built';
	export call_queue_bad_lBaseTemplate        							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::call_queue_bad::@version@';
	export call_queue_bad_lKeyTemplate         							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::call_queue_bad::@version@';      
	export call_queue_bad_lInputTemplate       							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::call_queue_bad' ;
	export call_queue_bad_lInputHistTemplate   							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::call_queue_bad::history';
	export call_queue_bad_Base                 							:= tools.mod_FilenamesBuild(call_queue_bad_lBaseTemplate, pversion);
	export call_queue_bad_Input															:= versioncontrol.mInputFileNameVersions(call_queue_bad_lInputTemplate);
	
	export group_practice_lBaseTemplate_built								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::group_practice::built';
	export group_practice_lBaseTemplate											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::group_practice::@version@';
	export group_practice_lKeyTemplate											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::group_practice::@version@';
	export group_practice_lInputTemplate										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::group_practice';
	export group_practice_lInputHistTemplate								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::group_practice::history';
	export group_practice_Base															:= tools.mod_FilenamesBuild(group_practice_lBaseTemplate, pversion);
	export group_practice_Input															:= versioncontrol.mInputFileNameVersions(group_practice_lInputTemplate);

	export aci_schedule_lBaseTemplate_built									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::aci_schedule::built';
	export aci_schedule_lBaseTemplate												:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::aci_schedule::@version@';
	export aci_schedule_lKeyTemplate												:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::aci_schedule::@version@';
	export aci_schedule_lInputTemplate											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::aci_schedule';
	export aci_schedule_lInputHistTemplate									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::aci_schedule::history';
	export aci_schedule_Base																:= tools.mod_FilenamesBuild(aci_schedule_lBaseTemplate, pversion);
	export aci_schedule_Input																:= versioncontrol.mInputFileNameVersions(aci_schedule_lInputTemplate);
	
	export business_activities_lu_lBaseTemplate_built				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::business_activities_lu::built';
	export business_activities_lu_lBaseTemplate							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::business_activities_lu::@version@';
	export business_activities_lu_lKeyTemplate							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::business_activities_lu::@version@';
	export business_activities_lu_lInputTemplate						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::business_activities_lu';
	export business_activities_lu_lInputHistTemplate				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::business_activities_lu::history';
	export business_activities_lu_Base											:= tools.mod_FilenamesBuild(business_activities_lu_lBaseTemplate, pversion);
	export business_activities_lu_Input											:= versioncontrol.mInputFileNameVersions(business_activities_lu_lInputTemplate);
	
	export cms_ecp_lBaseTemplate_built											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::cms_ecp::built';
	export cms_ecp_lBaseTemplate														:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::cms_ecp::@version@';
	export cms_ecp_lKeyTemplate															:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::cms_ecp::@version@';
	export cms_ecp_lInputTemplate														:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::cms_ecp';
	export cms_ecp_lInputHistTemplate												:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::cms_ecp::history';
	export cms_ecp_Base																			:= tools.mod_FilenamesBuild(cms_ecp_lBaseTemplate, pversion);
	export cms_ecp_Input																		:= versioncontrol.mInputFileNameVersions(cms_ecp_lInputTemplate);
	 
	export opi_lBaseTemplate_built													:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::opi::built';
	export opi_lBaseTemplate																:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::opi::@version@';
	export opi_lKeyTemplate																	:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::opi::@version@';
	export opi_lInputTemplate																:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::opi';
	export opi_lInputHistTemplate														:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::opi::history';
	export opi_Base																					:= tools.mod_FilenamesBuild(opi_lBaseTemplate, pversion);
	export opi_Input																				:= versioncontrol.mInputFileNameVersions(opi_lInputTemplate);
		
	export opi_facility_lBaseTemplate_built									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::opi_facility::built';
	export opi_facility_lBaseTemplate												:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::opi_facility::@version@';
	export opi_facility_lKeyTemplate												:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::opi_facility::@version@';
	export opi_facility_lInputTemplate											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::opi_facility';
	export opi_facility_lInputHistTemplate									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::opi_facility::history';
	export opi_facility_Base																:= tools.mod_FilenamesBuild(opi_facility_lBaseTemplate, pversion);
	export opi_facility_Input																:= versioncontrol.mInputFileNameVersions(opi_facility_lInputTemplate);

	export abms_cert_lu_lBaseTemplate_built									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::abms_cert_lu::built';
	export abms_cert_lu_lBaseTemplate												:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::abms_cert_lu::@version@';
	export abms_cert_lu_lKeyTemplate												:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::abms_cert_lu::@version@';
	export abms_cert_lu_lInputTemplate											:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::abms_cert_lu';
	export abms_cert_lu_lInputHistTemplate									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::abms_cert_lu::history';
	export abms_cert_lu_Base																:= tools.mod_FilenamesBuild(abms_cert_lu_lBaseTemplate, pversion);
	export abms_cert_lu_Input																:= versioncontrol.mInputFileNameVersions(abms_cert_lu_lInputTemplate);
	
	export abms_cooked_lBaseTemplate_built									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::abms_cooked::built';
	export abms_cooked_lBaseTemplate												:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::abms_cooked::@version@';
	export abms_cooked_lKeyTemplate													:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::abms_cooked::@version@';
	export abms_cooked_lInputTemplate												:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::abms_cooked';
	export abms_cooked_lInputHistTemplate										:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::abms_cooked::history';
	export abms_cooked_Base																	:= tools.mod_FilenamesBuild(abms_cert_lu_lBaseTemplate, pversion);
	export abms_cooked_Input																:= versioncontrol.mInputFileNameVersions(abms_cert_lu_lInputTemplate);
		
	export individual_qa_test_lInputTemplate  	     				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::individual::qa_test' ;
	export facility_qa_test_lInputTemplate  	  	   				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::facility::qa_test' ;
	export basc_claims_qa_test_lInputTemplate  	    				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::basc_claims::qa_test' ;
	export basc_cp_qa_test_lInputTemplate  	   			 				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::basc_cp::qa_test' ;
	export basc_deceased_qa_test_lInputTemplate  		 				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::basc_deceased::qa_test' ;
	export basc_facility_mme_qa_test_lInputTemplate  		 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::basc_facility_mme::qa_test' ;
	export best_hospital_qa_test_lInputTemplate  				 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::best_hospital::qa_test' ;
	export claims_addr_master_qa_test_lInputTemplate  	 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::claims_addr_master::qa_test' ;
	export claims_by_month_qa_test_lInputTemplate  			 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::claims_by_month::qa_test' ;
	export cms_ecp_qa_test_lInputTemplate  							 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::cms_ecp::qa_test' ;
	export group_lu_qa_test_lInputTemplate  						 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::group_lu::qa_test' ;
	export hospital_lu_qa_test_lInputTemplate  					 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::hospital_lu::qa_test' ;
	export lic_filedate_qa_test_lInputTemplate  				 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::lic_filedate::qa_test' ;
	export nanpa_qa_test_lInputTemplate  								 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::nanpa::qa_test' ;
	export npi_extension_qa_test_lInputTemplate  				 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::npi_extension::qa_test' ;
	export npi_extension_facility_qa_test_lInputTemplate 		:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::npi_extension_facility::qa_test' ;
	export npi_tin_xref_qa_test_lInputTemplate 							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::npi_tin_xref::qa_test' ;
	export office_attributes_qa_test_lInputTemplate 				:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::office_attributes::qa_test' ;
	export office_attributes_facility_qa_test_lInputTemplate:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::office_attributes_facility::qa_test' ;
	export opi_qa_test_lInputTemplate												:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::opi::qa_test' ;
	export opi_facility_qa_test_lInputTemplate							:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::opi_facility::qa_test' ;
	export source_confidence_lu_qa_test_lInputTemplate			:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::source_confidence_lu::qa_test' ;
	export abms_cooked_qa_test_lInputTemplate								:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::abms_cooked::qa_test' ;

end;
