import tools;

export Keynames(string		pversion			= '',   boolean pUseProd = false) := module

	export facility_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::facility::@version@::'	;
	export individual_lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::individual::@version@::'	;
	export associate_lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::associate::@version@::'	;
  export address_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::address::@version@::'	;
  export dea_lFileTemplate	    			:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::dea::@version@::'	;
  export license_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::license::@version@::'	;
  export taxonomy_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::taxonomy::@version@::'	;
  export npi_lFileTemplate	    			:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::npi::@version@::'	;
	export medschool_lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::medschool::@version@::'	;
	export tax_codes_lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::tax_codes::@version@::'	;
	export prov_ssn_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::provider_ssn::@version@::'	;
	export specialty_lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::specialty::@version@::'	;
	export sanc_prov_type_lFileTemplate	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::sanc_prov_type::@version@::'	;
	export sanc_codes_lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::sanc_codes::@version@::'	;
	// export dea_BAcodes_lFileTemplate	  := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::dea_BAcodes::@version@::'	;
	export prov_birthdate_lFileTemplate	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::provider_birthdate::@version@::'	;
	export sanction_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::sanction::@version@::'	;
	
	// facility keys - group_key and addr_key
	shared facility_lgroup_key				:= facility_lFileTemplate + 'group_key';
	export facility_group_key				:= tools.mod_FilenamesBuild(facility_lgroup_key	,pversion);
	export facility_group_dAll_filenames	:= facility_group_key.dAll_filenames;

	shared facility_laddr_key				:= facility_lFileTemplate + 'addr_key';
	export facility_addr_key				:= tools.mod_FilenamesBuild(facility_laddr_key	,pversion);
	export facility_addr_dAll_filenames	:= facility_addr_key.dAll_filenames;
	
	export facility	:= facility_addr_key.dAll_filenames + facility_group_key.dAll_filenames;

	// individual keys - group_key, lnpid
	shared individual_lgroup_key		:= individual_lFileTemplate + 'group_key';
	export individual_group_key			:= tools.mod_FilenamesBuild(individual_lgroup_key	,pversion);
	export individual_group_dAll_filenames	:= individual_group_key.dAll_filenames;

	shared individual_llnpid				:= individual_lFileTemplate + 'lnpid';
	export individual_lnpid					:= tools.mod_FilenamesBuild(individual_llnpid	,pversion);
	export individual_lnpid_dAll_filenames	:= individual_lnpid.dAll_filenames;
	
	export individual	:= individual_group_key.dAll_filenames + individual_lnpid.dAll_filenames;

	// associate keys - group_key, addr_key
	shared associate_lgroup_key			:= associate_lFileTemplate + 'group_key';
	export associate_group_key			:= tools.mod_FilenamesBuild(associate_lgroup_key	,pversion);
	export associate_group_dAll_filenames	:= associate_group_key.dAll_filenames;

	shared associate_laddr_key			:= associate_lFileTemplate + 'addr_key';
	export associate_addr_key				:= tools.mod_FilenamesBuild(associate_laddr_key	,pversion);
	export associate_addr_dAll_filenames	:= associate_addr_key.dAll_filenames;
	
	shared associate_lbill_tin			:= associate_lFileTemplate + 'bill_tin';
	export associate_bill_tin				:= tools.mod_FilenamesBuild(associate_lbill_tin	,pversion);
	export associate_bill_tin_dAll_filenames	:= associate_bill_tin.dAll_filenames;

	shared associate_lbgk			:= associate_lFileTemplate + 'billing_group_key';
	export associate_bgk			:= tools.mod_FilenamesBuild(associate_lbgk	,pversion);
	export associate_bgk_dAll_filenames	:= associate_bgk.dAll_filenames;
	
	export associate	:= associate_group_key.dAll_filenames
										+  associate_addr_key.dAll_filenames
										+  associate_bill_tin.dAll_filenames
										+  associate_bgk.dAll_filenames;

	// address keys - group_key, addr_key
	shared address_lgroup_key				:= address_lFileTemplate + 'group_key';
	export address_group_key				:= tools.mod_FilenamesBuild(address_lgroup_key	,pversion);
	export address_group_dAll_filenames	:= address_group_key.dAll_filenames;

	shared address_laddr_key				:= address_lFileTemplate + 'addr_key';
	export address_addr_key					:= tools.mod_FilenamesBuild(address_laddr_key	,pversion);
	export address_addr_dAll_filenames	:= address_addr_key.dAll_filenames;
	
	export address	:= address_group_key.dAll_filenames + address_addr_key.dAll_filenames;

	// dea keys - group_key, dea_num
	shared dea_lgroup_key						:= dea_lFileTemplate + 'group_key';
	export dea_group_key						:= tools.mod_FilenamesBuild(dea_lgroup_key	,pversion);
	export dea_group_dAll_filenames	:= dea_group_key.dAll_filenames;

	shared dea_ldea_num				:= dea_lFileTemplate + 'dea_num';
	export dea_dea_num				:= tools.mod_FilenamesBuild(dea_ldea_num	,pversion);
	export dea_dea_dAll_filenames	:= dea_dea_num.dAll_filenames;
	
	export dea	:= dea_group_key.dAll_filenames + dea_dea_num.dAll_filenames;

	// license keys - group_key, lic_num
	shared license_lgroup_key				:= license_lFileTemplate + 'group_key';
	export license_group_key				:= tools.mod_FilenamesBuild(license_lgroup_key	,pversion);
	export license_group_dAll_filenames	:= license_group_key.dAll_filenames;

	shared license_llic_num		:= license_lFileTemplate + 'lic_num';
	export license_lic_num		:= tools.mod_FilenamesBuild(license_llic_num	,pversion);
	export license_lic_dAll_filenames	:= license_lic_num.dAll_filenames;
	
	export license	:= license_group_key.dAll_filenames + license_lic_num.dAll_filenames;

	// taxonomy keys - group_key, taxonomy
	shared taxonomy_lgroup_key			:= taxonomy_lFileTemplate + 'group_key';
	export taxonomy_group_key				:= tools.mod_FilenamesBuild(taxonomy_lgroup_key	,pversion);
	export taxonomy_group_dAll_filenames	:= taxonomy_group_key.dAll_filenames;

	shared taxonomy_ltaxonomy				:= taxonomy_lFileTemplate + 'taxonomy';
	export taxonomy_taxonomy				:= tools.mod_FilenamesBuild(taxonomy_ltaxonomy	,pversion);
	export taxonomy_tax_dAll_filenames	:= taxonomy_taxonomy.dAll_filenames;
	
	export taxonomy	:= taxonomy_group_key.dAll_filenames + taxonomy_taxonomy.dAll_filenames;

	// npi keys - group_key, npi_num
	shared npi_lgroup_key							:= npi_lFileTemplate + 'group_key';
	export npi_group_key						:= tools.mod_FilenamesBuild(npi_lgroup_key	,pversion);
	export npi_group_dAll_filenames	:= npi_group_key.dAll_filenames;

	shared npi_lnpi_num				:= npi_lFileTemplate + 'npi_num';
	export npi_npi_num				:= tools.mod_FilenamesBuild(npi_lnpi_num	,pversion);
	export npi_npi_dAll_filenames	:= npi_npi_num.dAll_filenames;
	
	export npi	:= npi_group_key.dAll_filenames + npi_npi_num.dAll_filenames;

	// medschool keys - group_key
	shared medschool_lgroup_key				:= medschool_lFileTemplate + 'group_key';
	export medschool_group_key			:= tools.mod_FilenamesBuild(medschool_lgroup_key	,pversion);
	export medschool_group_dAll_filenames	:= medschool_group_key.dAll_filenames;
	
	export medschool	:= medschool_group_key.dAll_filenames;

	// prov_ssn keys - group_key, ssn
	shared prov_ssn_lgroup_key			:= prov_ssn_lFileTemplate + 'group_key';
	export prov_ssn_group_key				:= tools.mod_FilenamesBuild(prov_ssn_lgroup_key	,pversion);
	export prov_ssn_group_dAll_filenames	:= prov_ssn_group_key.dAll_filenames;
	
	shared prov_ssn_lssn			:= prov_ssn_lFileTemplate + 'ssn';
	export prov_ssn_ssn				:= tools.mod_FilenamesBuild(prov_ssn_lssn	,pversion);
	export prov_ssn_ssn_dAll_filenames	:= prov_ssn_ssn.dAll_filenames;
	
	export prov_ssn	:= prov_ssn_group_key.dAll_filenames + prov_ssn_ssn.dAll_filenames;

	// prov_birthdate keys - group_key
	shared prov_birthdate_lgroup_key	:= prov_birthdate_lFileTemplate + 'group_key';
	export prov_birthdate_group_key		:= tools.mod_FilenamesBuild(prov_birthdate_lgroup_key	,pversion);
	export prov_birthdate_group_dAll_filenames	:= prov_birthdate_group_key.dAll_filenames;
	
	export prov_birthdate	:= prov_birthdate_group_key.dAll_filenames;

	// sanction keys - group_key
	shared sanction_lgroup_key			:= sanction_lFileTemplate + 'group_key';
	export sanction_group_key				:= tools.mod_FilenamesBuild(sanction_lgroup_key	,pversion);
	export sanction_group_dAll_filenames	:= sanction_group_key.dAll_filenames;
	
	export sanction	:= sanction_group_key.dAll_filenames;
	
	// sanc_codes keys - sanc_code
	shared sanc_codes_lsanc_codes		:= sanc_codes_lFileTemplate + 'sanc_codes';
	export sanc_codes_sanc_codes		:= tools.mod_FilenamesBuild(sanc_codes_lsanc_codes, pversion);
	export sanc_codes_sanc_dAll_filenames	:= sanc_codes_sanc_codes.dAll_filenames;
	
	export sanc_codes	:= sanc_codes_sanc_codes.dAll_filenames;

	// sanc_prov_type keys - sanc_prov_type_code
	shared sanc_prov_type_lsanc_prov_type_code	:= sanc_prov_type_lFileTemplate + 'prov_type_code';
	export sanc_prov_type_sanc_prov_type_code		:= tools.mod_FilenamesBuild(sanc_prov_type_lsanc_prov_type_code, pversion);
	export sanc_prov_type_sanc_prov_type_dAll_filenames	:= sanc_prov_type_sanc_prov_type_code.dAll_filenames;
	
	export sanc_prov_type	:= sanc_prov_type_sanc_prov_type_code.dAll_filenames;
	
	// tax_codes keys - taxonomy
	shared tax_codes_ltaxonomy			:= tax_codes_lFileTemplate + 'taxonomy';
	export tax_codes_taxonomy				:= tools.mod_FilenamesBuild(tax_codes_ltaxonomy, pversion);
	export tax_codes_taxonomy_dAll_filenames	:= tax_codes_taxonomy.dAll_filenames;
	
	export tax_codes	:= tax_codes_taxonomy.dAll_filenames;
	
	//specialty keys - group_key+spec_code, spec_desc+group_key
	shared specialty_lgroup_key_spec_code	:= specialty_lFileTemplate + 'group_key_spec_code';
	export specialty_group_key_spec_code	:= tools.mod_FilenamesBuild(specialty_lgroup_key_spec_code, pversion);
	export specialty_group_spec_dAll_filenames	:= specialty_group_key_spec_code.dAll_filenames;
	
	shared specialty_lspec_desc_group_key	:= specialty_lFileTemplate + 'spec_desc_group_key';
	export specialty_spec_desc_group_key	:= tools.mod_FilenamesBuild(specialty_lspec_desc_group_key, pversion);
	export specialty_spec_desc_group_dAll_filenames	:= specialty_spec_desc_group_key.dAll_filenames;
	
	export specialty	:= specialty_group_key_spec_code.dAll_filenames + specialty_spec_desc_group_key.dAll_filenames;
	
	//dea_bacodes keys - dea_bus_act_ind+dea_bus_act_ind_sub
	// shared dea_bacodes_ldea_bus_act_ind		:= dea_bacodes_lFileTemplate + 'dea_bus_act_ind';
	// export dea_bacodes_dea_bus_act_ind		:= tools.mod_FilenamesBuild(dea_bacodes_ldea_bus_act_ind, pversion);
	// export dea_bacodes_dea_bus_dAll_filenames	:= dea_bacodes_dea_bus_act_ind.dAll_filenames;
	
	// export dea_bacodes	:= dea_bacodes_dea_bus_act_ind.dAll_filenames;

end;