// EXPORT Filenames_w_medschool := 'todo';
import versioncontrol,tools;

export Filenames_w_medschool(string pversion = '', boolean pUseProd = false) := module
  export individual_lBaseTemplate_built  :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::individual::built';
	export individual_lBaseTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::individual::@version@';
	export individual_lKeyTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::individual::@version@';	
	export individual_lInputTemplate       :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::individual' ;
	export individual_lInputHistTemplate   :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::individual::history';
	export individual_Base		             := tools.mod_FilenamesBuild(individual_lBaseTemplate, pversion);
	
	export facility_lBaseTemplate_built	   :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::facility::built';
	export facility_lBaseTemplate					 :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::facility::@version@';
	export facility_lKeyTemplate	  			 :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::facility::@version@';		
	export facility_lInputTemplate 				 :=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::facility' ;
	export facility_lInputHistTemplate 		 :=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::facility::history';
	export facility_Base		  						 :=tools.mod_FilenamesBuild(facility_lBaseTemplate, pversion);
	
	export dea_xref_lBaseTemplate_built    :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::dea_xref::built';
	export dea_xref_lBaseTemplate	         :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::dea_xref::@version@';
	export dea_xref_lKeyTemplate	         :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::dea_xref::@version@';	
	export dea_xref_lInputTemplate         :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::dea_xref' ;
	export dea_xref_lInputHistTemplate     :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::dea_xref::history';
	export dea_xref_Base		               :=tools.mod_FilenamesBuild(dea_xref_lBaseTemplate, pversion);
	
	export npi_tin_xref_lBaseTemplate_built  :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::npi_tin_xref::built';
	export npi_tin_xref_lBaseTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::npi_tin_xref::@version@';
	export npi_tin_xref_lKeyTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::npi_tin_xref::@version@';	
	export npi_tin_xref_lInputTemplate       :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::npi_tin_xref' ;
	export npi_tin_xref_lInputHistTemplate   :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::npi_tin_xref::history';
	export npi_tin_xref_Base		             :=tools.mod_FilenamesBuild(npi_tin_xref_lBaseTemplate, pversion);
	
  // export license_xref_lBaseTemplate_built  :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::license_xref::built';
	// export license_xref_lBaseTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::license_xref::@version@';
	// export license_xref_lKeyTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::license_xref::@version@';	
	// export license_xref_lInputTemplate       :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::license_xref' ;
	// export license_xref_lInputHistTemplate   :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::license_xref::history';
	// export license_xref_Base		             :=tools.mod_FilenamesBuild(license_xref_lBaseTemplate, pversion);
	
	export address_name_xref_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::address_name_xref::built';
	export address_name_xref_lBaseTemplate	     :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::address_name_xref::@version@';
	export address_name_xref_lKeyTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::address_name_xref::@version@';	
	export address_name_xref_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::address_name_xref' ;
	export address_name_xref_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::address_name_xref::history';
	export address_name_xref_Base		             :=tools.mod_FilenamesBuild(address_name_xref_lBaseTemplate, pversion);
	
	export facility_name_xref_lBaseTemplate_built  :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::facility_name_xref::built';
	export facility_name_xref_lBaseTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::facility_name_xref::@version@';
	export facility_name_xref_lKeyTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::facility_name_xref::@version@';	
	export facility_name_xref_lInputTemplate       :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::facility_name_xref' ;
	export facility_name_xref_lInputHistTemplate   :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::facility_name_xref::history';
	export facility_name_xref_Base		             :=tools.mod_FilenamesBuild(facility_name_xref_lBaseTemplate, pversion);
	
	
	
	export basc_cp_lBaseTemplate_built  :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::basc_cp::built';
	export basc_cp_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::basc_cp::@version@';
	export basc_cp_lKeyTemplate	        :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::basc_cp::@version@';	
	export basc_cp_lInputTemplate       :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::basc_cp' ;
	export basc_cp_lInputHistTemplate   :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::basc_cp::history';
	export basc_cp_Base		              := tools.mod_FilenamesBuild(basc_cp_lBaseTemplate, pversion);
	
	
	
	export basc_claims_lBaseTemplate_built  :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::basc_claims::built';
	export basc_claims_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::basc_claims::@version@';
	export basc_claims_lKeyTemplate	        :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::basc_claims::@version@';	
	export basc_claims_lInputTemplate       :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::basc_claims' ;
	export basc_claims_lInputHistTemplate   :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::basc_claims::history';
	export basc_claims_Base		              := tools.mod_FilenamesBuild(basc_claims_lBaseTemplate, pversion);
	
	export npi_extension_lBaseTemplate_built  :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::npi_extension::built';
	export npi_extension_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::npi_extension::@version@';
	export npi_extension_lKeyTemplate	        :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::npi_extension::@version@';	
	export npi_extension_lInputTemplate       :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::npi_extension' ;
	export npi_extension_lInputHistTemplate   :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::npi_extension::history';
	export npi_extension_Base		              := tools.mod_FilenamesBuild(npi_extension_lBaseTemplate, pversion);
	
	
	export npi_extension_facility_lBaseTemplate_built  :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::npi_extension_facility::built';
	export npi_extension_facility_lBaseTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::npi_extension_facility::@version@';
	export npi_extension_facility_lKeyTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::npi_extension_facility::@version@';	
	export npi_extension_facility_lInputTemplate       :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::npi_extension_facility' ;
	export npi_extension_facility_lInputHistTemplate   :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::npi_extension_facility::history';
	export npi_extension_facility_Base		             := tools.mod_FilenamesBuild(npi_extension_facility_lBaseTemplate, pversion);
	
	
	
	export claims_addr_master_lBaseTemplate_built  :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::claims_addr_master::built';
	export claims_addr_master_lBaseTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::claims_addr_master::@version@';
	export claims_addr_master_lKeyTemplate	       :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::claims_addr_master::@version@';	
	export claims_addr_master_lInputTemplate       :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::claims_addr_master' ;
	export claims_addr_master_lInputHistTemplate   :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::claims_addr_master::history';
	export claims_addr_master_Base		             := tools.mod_FilenamesBuild(claims_addr_master_lBaseTemplate, pversion);
	
  export taxonomy_equiv_lBaseTemplate_built   := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::taxonomy_equiv::built';
    export taxonomy_equiv_lBaseTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::taxonomy_equiv::@version@';
    export taxonomy_equiv_lKeyTemplate          := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::taxonomy_equiv::@version@';      
    export taxonomy_equiv_lInputTemplate        := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::taxonomy_equiv' ;
    export taxonomy_equiv_lInputHistTemplate    := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::taxonomy_equiv::history';
    export taxonomy_equiv_Base                  := tools.mod_FilenamesBuild(taxonomy_equiv_lBaseTemplate, pversion);

    export claims_by_month_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::claims_by_month::built';
    export claims_by_month_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::claims_by_month::@version@';
    export claims_by_month_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::claims_by_month::@version@';      
    export claims_by_month_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::claims_by_month' ;
    export claims_by_month_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::claims_by_month::history';
    export claims_by_month_Base                 := tools.mod_FilenamesBuild(claims_by_month_lBaseTemplate, pversion);

    export basc_deceased_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::basc_deceased::built';
    export basc_deceased_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::basc_deceased::@version@';
    export basc_deceased_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::basc_deceased::@version@';      
    export basc_deceased_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::basc_deceased' ;
    export basc_deceased_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::basc_deceased::history';
    export basc_deceased_Base                 := tools.mod_FilenamesBuild(basc_deceased_lBaseTemplate, pversion);


    export basc_addr_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::basc_addr::built';
    export basc_addr_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::basc_addr::@version@';
    export bbasc_addr_lKeyTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::basc_addr::@version@';      
    export basc_addr_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::basc_addr' ;
    export basc_addr_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::basc_addr::history';
    export basc_addr_Base                 := tools.mod_FilenamesBuild(basc_addr_lBaseTemplate, pversion);


    export client_data_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::client_data::built';
    export client_data_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::client_data::@version@';
    export client_data_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::client_data::@version@';      
    export client_data_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::client_data' ;
    export client_data_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::client_data::history';
    export client_data_Base                 := tools.mod_FilenamesBuild(client_data_lBaseTemplate, pversion);
	
    export office_attributes_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::office_attributes::built';
    export office_attributes_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::office_attributes::@version@';
    export office_attributes_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::office_attributes::@version@';      
    export office_attributes_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::office_attributes' ;
    export office_attributes_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::office_attributes::history';
    export office_attributes_Base                 := tools.mod_FilenamesBuild(office_attributes_lBaseTemplate, pversion);
		
		
		export office_attributes_facility_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::office_attributes_facility::built';
    export office_attributes_facility_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::office_attributes_facility::@version@';
    export office_attributes_facility_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::office_attributes_facility::@version@';      
    export office_attributes_facility_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::office_attributes_facility' ;
    export office_attributes_facility_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::office_attributes_facility::history';
    export office_attributes_facility_Base                 := tools.mod_FilenamesBuild(office_attributes_facility_lBaseTemplate, pversion);
		
		
		export std_terms_lu_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::std_terms_lu ::built';
    export std_terms_lu_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::std_terms_lu ::@version@';
    export std_terms_lu_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::std_terms_lu ::@version@';      
    export std_terms_lu_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::std_terms_lu ' ;
    export std_terms_lu_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::std_terms_lu ::history';
		export std_terms_lu_Base                 := tools.mod_FilenamesBuild(std_terms_lu_lBaseTemplate, pversion);


    export taxonomy_full_lu_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::taxonomy_full_lu ::built';
    export taxonomy_full_lu_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::taxonomy_full_lu ::@version@';
    export taxonomy_full_lu_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::taxonomy_full_lu ::@version@';      
    export taxonomy_full_lu_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::taxonomy_full_lu ' ;
    export taxonomy_full_lu_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::taxonomy_full_lu ::history';
    export taxonomy_full_lu_Base                 := tools.mod_FilenamesBuild(taxonomy_full_lu_lBaseTemplate, pversion);

    export dir_confidence_2010_lu_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::dir_confidence_2010_lu ::built';
    export dir_confidence_2010_lu_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::dir_confidence_2010_lu ::@version@';
    export dir_confidence_2010_lu_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::dir_confidence_2010_lu ::@version@';      
    export dir_confidence_2010_lu_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::dir_confidence_2010_lu ' ;
    export dir_confidence_2010_lu_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::dir_confidence_2010_lu ::history';
    export dir_confidence_2010_lu_Base                 := tools.mod_FilenamesBuild(dir_confidence_2010_lu_lBaseTemplate, pversion);

    export specialty_lu_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::specialty_lu ::built';
    export specialty_lu_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::specialty_lu ::@version@';
    export specialty_lu_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::specialty_lu ::@version@';      
    export specialty_lu_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::specialty_lu ' ;
    export specialty_lu_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::specialty_lu ::history';
    export specialty_lu_Base                 := tools.mod_FilenamesBuild(specialty_lu_lBaseTemplate, pversion);

    export group_lu_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::group_lu ::built';
    export group_lu_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::group_lu ::@version@';
    export group_lu_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::group_lu ::@version@';      
    export group_lu_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::group_lu ' ;
    export group_lu_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::group_lu ::history';
    export group_lu_Base                 := tools.mod_FilenamesBuild(group_lu_lBaseTemplate, pversion);

    export hospital_lu_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::hospital_lu ::built';
    export hospital_lu_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::hospital_lu ::@version@';
    export hospital_lu_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::hospital_lu ::@version@';      
    export hospital_lu_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hospital_lu';
    export hospital_lu_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::hospital_lu::history';
    export hospital_lu_Base                 := tools.mod_FilenamesBuild(hospital_lu_lBaseTemplate, pversion);

    

    export lic_xref_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::lic_xref::built';
    export lic_xref_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::lic_xref::@version@';
    export lic_xref_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild'+ '::lic_xref ::@version@';      
    export lic_xref_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::lic_xref';
    export lic_xref_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::lic_xref::history';
    export lic_xref_Base                 := tools.mod_FilenamesBuild(lic_xref_lBaseTemplate, pversion);


    

    export addr_name_xref_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::addr_name_xref ::built';
    export addr_name_xref_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::addr_name_xref ::@version@';
    export addr_name_xref_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::addr_name_xref ::@version@';      
    export addr_name_xref_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::addr_name_xref ' ;
    export addr_name_xref_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::addr_name_xref ::history';
    export addr_name_xref_Base                 := tools.mod_FilenamesBuild(addr_name_xref_lBaseTemplate, pversion);

    export basc_facility_mme_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::basc_facility_mme ::built';
    export basc_facility_mme_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::basc_facility_mme ::@version@';
    export basc_facility_mme_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::basc_facility_mme ::@version@';      
    export basc_facility_mme_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::basc_facility_mme ' ;
    export basc_facility_mme_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::basc_facility_mme ::history';
    export basc_facility_mme_Base                 := tools.mod_FilenamesBuild(basc_facility_mme_lBaseTemplate, pversion);

    export lic_filedate_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::lic_filedate ::built';
    export lic_filedate_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::lic_filedate ::@version@';
    export lic_filedate_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::lic_filedate ::@version@';      
    export lic_filedate_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::lic_filedate ' ;
    export lic_filedate_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::lic_filedate ::history';
    export lic_filedate_Base                 := tools.mod_FilenamesBuild(lic_filedate_lBaseTemplate, pversion);

    export nanpa_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::nanpa ::built';
    export nanpa_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::nanpa ::@version@';
    export nanpa_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::nanpa ::@version@';      
    export nanpa_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::nanpa ' ;
    export nanpa_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::nanpa ::history';
    export nanpa_Base                 := tools.mod_FilenamesBuild(nanpa_lBaseTemplate, pversion);
		
    export best_hospital_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::best_hospital ::built';
    export best_hospital_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::best_hospital ::@version@';
    export best_hospital_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::best_hospital ::@version@';      
    export best_hospital_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::best_hospital ' ;
    export best_hospital_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::best_hospital ::history';
    export best_hospital_Base                 := tools.mod_FilenamesBuild(best_hospital_lBaseTemplate, pversion);
		
		export last_name_stats_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::last_name_stats ::built';
    export last_name_stats_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::last_name_stats ::@version@';
    export last_name_stats_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::last_name_stats ::@version@';      
    export last_name_stats_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::last_name_stats ' ;
    export last_name_stats_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::last_name_stats ::history';
    export last_name_stats_Base                 := tools.mod_FilenamesBuild(last_name_stats_lBaseTemplate, pversion);
		
		export source_confidence_lu_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::source_confidence_lu ::built';
		export source_confidence_lu_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::source_confidence_lu ::@version@';
		export source_confidence_lu_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::source_confidence_lu ::@version@';      
		export source_confidence_lu_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::source_confidence_lu ' ;
		export source_confidence_lu_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::source_confidence_lu ::history';
		export source_confidence_lu_Base                 := tools.mod_FilenamesBuild(source_confidence_lu_lBaseTemplate, pversion);
		
		export ignore_terms_lu_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::ignore_terms_lu ::built';
		export ignore_terms_lu_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::ignore_terms_lu ::@version@';
		export ignore_terms_lu_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::ignore_terms_lu ::@version@';      
		export ignore_terms_lu_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::ignore_terms_lu ' ;
		export ignore_terms_lu_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::ignore_terms_lu ::history';
		export ignore_terms_lu_Base                 := tools.mod_FilenamesBuild(ignore_terms_lu_lBaseTemplate, pversion);
		
		export taxon_lu_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::taxon_lu ::built';
		export taxon_lu_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::taxon_lu ::@version@';
		export taxon_lu_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::taxon_lu ::@version@';      
		export taxon_lu_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::taxon_lu ' ;
		export taxon_lu_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::taxon_lu ::history';
		export taxon_lu_Base                 := tools.mod_FilenamesBuild(taxon_lu_lBaseTemplate, pversion);
		
		
		export abbr_lu_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::abbr_lu ::built';
		export abbr_lu_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::abbr_lu ::@version@';
		export abbr_lu_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::abbr_lu ::@version@';      
		export abbr_lu_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::abbr_lu ' ;
		export abbr_lu_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::abbr_lu ::history';
		export abbr_lu_Base                 := tools.mod_FilenamesBuild(abbr_lu_lBaseTemplate, pversion);
		
		export call_queue_bad_lBaseTemplate_built  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::call_queue_bad ::built';
		export call_queue_bad_lBaseTemplate        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::call_queue_bad ::@version@';
		export call_queue_bad_lKeyTemplate         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::call_queue_bad ::@version@';      
		export call_queue_bad_lInputTemplate       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::call_queue_bad' ;
		export call_queue_bad_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::call_queue_bad ::history';
		export call_queue_bad_Base                 := tools.mod_FilenamesBuild(call_queue_bad_lBaseTemplate, pversion);

   export medschool_lBaseTemplate             := _Dataset(pUseProd).thor_cluster_files +'base::'+ _Dataset().name+ '::medschool';
		//export medschool_Base                      := tools.mod_FilenamesBuild(medschool_lBaseTemplate, pversion);
		export medschool_wordlist_lBaseTemplate    := _Dataset(pUseProd).thor_cluster_files + 'base::'+_Dataset().name+ '::medschool_wordlist';
		//export medschool_wordlist_Base                      := tools.mod_FilenamesBuild(medschool_wordlist_lBaseTemplate, pversion);
		//export medschool_wordlist_Base                      := tools.mod_FilenamesBuild(medschool_wordlist_lBaseTemplate, pversion);
    export non_medschool_lBaseTemplate          := _Dataset(pUseProd).thor_cluster_files +'base::'+ _Dataset().name+ '::non_medschool';
		//export nonmedschool_Base                   := tools.mod_FilenamesBuild(medschool_lBaseTemplate, pversion);
		export non_medschool_wordlist_lBaseTemplate := _Dataset(pUseProd).thor_cluster_files + 'base::'+_Dataset().name+ '::non_medschool_wordlist';
		//export nonmedschool_wordlist_Base                   := tools.mod_FilenamesBuild(medschool_wordlist_lBaseTemplate, pversion);

/* 	export dAll_filenames :=
   		   Base.dAll_filenames		 
   	;
*/


end;
