import doxie, tools;

export Keys(string		pversion							= '',boolean pUseProd = false) := module

	shared facility_Base						:= Files(pversion,pUseProd).facility_Base.Built;
	shared fac_Base_gk							:= facility_Base(group_key <> '');
	shared fac_Base_ak							:= facility_Base(addr_key <> '');

	shared individual_Base					:= Files(pversion,pUseProd).individual_Base.Built;
	shared ind_Base_gk							:= individual_Base(group_key <> '');
	shared ind_Base_lnpid						:= individual_Base(lnpid > 0);

	shared associate_Base						:= Files(pversion,pUseProd).associate_Base.Built;
	shared assoc_Base_gk						:= associate_Base(group_key <> '');
	shared assoc_Base_ak						:= associate_Base(addr_key <> '');
	shared assoc_Base_bill_tin			:= dedup(associate_Base((unsigned)bill_tin > 0),bill_tin,group_key,sloc_group_key,billing_group_key,all);
	shared associate_base_bk				:= associate_Base(billing_group_key <> '');

	shared address_Base							:= Files(pversion,pUseProd).address_Base.Built;
	shared add_Base_gk							:= address_Base(group_key <> '');
	shared add_Base_ak							:= address_Base(addr_key <> '');

	shared dea_Base									:= Files(pversion,pUseProd).dea_Base.Built;
	shared dea_Base_gk							:= dea_Base(group_key <> '');
	shared dea_Base_dea							:= dea_Base(dea_num <> '');

	// shared license_Base							:= Files(pversion,pUseProd).license_Base.Built;
	// Modification 20180703 - Sometime this year, the MO nurse practitioner licensing boards stopped providing updated records when a
	// provider surrendered their license, or it was revoked, or any other reason it became expired prematurely.  Expired licenses no
	// longer appear in the list provided by the board, so the absence of a previously issued license from this list implies it is 
	// expired.  For the purposes of this build, since the license record was previously received with a future expiration date 
	// that could now be erroneous, the license_base build was changed to create an additional "persist" file to wipe out what is
	// assumed to be bad expiration dates, and then the key created from that base.  It is important to know that the original license
	// base still contains the expiration dates, so this means that the key and the base file will not match for the qualifying records.
	// The modified code for this additional persist file can be found in Enclarity.Update_base.Modified_License_base.
	
	make_lic_base	:= 									Update_Base(pversion,pUseProd).Modified_License_Base; 
	
	// shared license_base							:= make_lic_base;
	shared license_base							:= dataset('~thor_data400::base::enclarity::modified_license_persist_for_keys::' + pversion, enclarity.Layouts.license_base, thor);
	shared lic_Base_gk							:= license_Base(group_key <> '');
	shared lic_Base_lic							:= license_Base(lic_num_in <> '');

	shared taxonomy_Base						:= Files(pversion,pUseProd).taxonomy_Base.Built;
	shared tax_Base_gk							:= taxonomy_Base(group_key <> '');
	shared tax_Base_tax							:= taxonomy_Base(taxonomy <> '');

	shared npi_Base									:= Files(pversion,pUseProd).npi_Base.Built;
	shared npi_Base_gk							:= npi_Base(group_key <> '');
	shared npi_Base_npi							:= npi_Base(npi_num <> '');

	shared medschool_Base						:= Files(pversion,pUseProd).medschool_Base.Built;
	shared med_Base_gk							:= medschool_Base(group_key <> '');

	shared tax_codes_Base						:= Files(pversion,pUseProd).tax_codes_Base.Built;
	shared tax_codes_Base_tax				:= tax_codes_Base(taxonomy <> '');

	shared prov_ssn_Base						:= Files(pversion,pUseProd).prov_ssn_Base.Built;
	shared prov_ssn_Base_gk					:= prov_ssn_Base(group_key <> '');
	shared prov_ssn_Base_ssn				:= prov_ssn_Base(ssn <> '');
	
	shared prov_birthdate_Base			:= Files(pversion,pUseProd).prov_birthdate_Base.Built;
	shared prov_birth_Base_gk				:= prov_birthdate_Base(group_key <> '');

	shared sanction_Base						:= project(Files(pversion,pUseProd).sanction_Base.Built, Layouts.sanction_base - [Enc_derived_rein_date, Enc_derived_rein_flag]);
	shared sanc_Base_gk							:= sanction_Base(group_key <> '');

	shared sanc_codes_Base					:= Files(pversion,pUseProd).sanc_codes_Base.Built;
	shared sanc_codes_Base_code			:= sanc_codes_Base(sanc_code <> '');
	
	shared sanc_prov_type_Base			:= Files(pversion,pUseProd).sanc_prov_type_Base.Built;
	shared sanc_prov_type_Base_code	:= sanc_prov_type_Base(prov_type_code <> '');

	shared specialty_Base						:= Files(pversion,pUseProd).specialty_Base.Built;
	shared specialty_Base_gk				:= specialty_Base(group_key <> '');

	// facility keys - group_key and addr_key
	tools.mac_FilesIndex('facility_base		,{group_key	}	  ,{{Fac_Base_gk}-[medicare_fac_num1'
						+',clia_status_code'
            +',clia_num'
            +',clia_end_date'
            +',clia_cert_type_code'
            +',clia_cert_eff_date'
            +',ncpdp_id'
            +',tin1'
            +',clean_clia_end_date'
            +',clean_clia_cert_eff_date'
            +']	}'	,keynames(pversion,pUseProd).facility_group_key		,facility_group_key	 );
	tools.mac_FilesIndex('facility_base		,{addr_key	}	  ,{Fac_Base_ak	}'	,keynames(pversion,pUseProd).facility_addr_key		,facility_addr_key	 );
		
	// individual keys - group_key, lnpid
	tools.mac_FilesIndex('individual_base		,{group_key	}	  ,{ind_Base_gk			}'	,keynames(pversion,pUseProd).individual_group_key		,individual_group_key	 );
	tools.mac_FilesIndex('individual_base(lnpid>0)		,{lnpid			}	  ,{ind_Base_lnpid	}'	,keynames(pversion,pUseProd).individual_lnpid		,individual_lnpid	 );

	// associate keys - group_key, addr_key
	tools.mac_FilesIndex('associate_base		,{group_key	}	  ,{assoc_Base_gk	}'	,keynames(pversion,pUseProd).associate_group_key		,associate_group_key	 );
	tools.mac_FilesIndex('associate_base		,{addr_key	}	  ,{assoc_Base_ak	}'	,keynames(pversion,pUseProd).associate_addr_key		,associate_addr_key	 );
	tools.mac_FilesIndex('assoc_Base_bill_tin,{bill_tin},{group_key,sloc_group_key,billing_group_key}'	,keynames(pversion,pUseProd).associate_bill_tin		,associate_bill_tin	 );
	tools.mac_FilesIndex('associate_base_bk ,{billing_group_key},{associate_base_bk}'	,keynames(pversion,pUseProd).associate_bgk		,associate_bgk	 );
		
	// address keys - group_key, addr_key
	tools.mac_FilesIndex('address_base		,{group_key	}	  ,{add_Base_gk	}'	,keynames(pversion,pUseProd).address_group_key		,address_group_key	 );
	tools.mac_FilesIndex('address_base		,{addr_key	}	  ,{add_Base_ak	}'	,keynames(pversion,pUseProd).address_addr_key		,address_addr_key	 );
		
	// dea keys - group_key, dea_num
	tools.mac_FilesIndex('dea_base		,{group_key	}	  ,{dea_Base_gk	}'	,keynames(pversion,pUseProd).dea_group_key		,dea_group_key	 );
	tools.mac_FilesIndex('dea_base		,{dea_num		}	  ,{dea_Base_dea}'	,keynames(pversion,pUseProd).dea_dea_num		,dea_dea_num	 );

	// license keys - group_key, lic_num
	tools.mac_FilesIndex('license_base		,{group_key	}	  ,{lic_Base_gk	}'	,keynames(pversion,pUseProd).license_group_key		,license_group_key	 );
	tools.mac_FilesIndex('license_base		,{lic_num_in}	  ,{lic_Base_lic}'	,keynames(pversion,pUseProd).license_lic_num		,license_lic_num	 );
		
	// taxonomy keys - group_key, taxonomy
	tools.mac_FilesIndex('taxonomy_base		,{group_key	}	  ,{tax_Base_gk	}'	,keynames(pversion,pUseProd).taxonomy_group_key		,taxonomy_group_key	 );
	tools.mac_FilesIndex('taxonomy_base		,{taxonomy	}	  ,{tax_Base_tax}'	,keynames(pversion,pUseProd).taxonomy_taxonomy		,taxonomy_taxonomy	 );

	// npi keys - group_key, npi_num
	tools.mac_FilesIndex('npi_base		,{group_key	}	  ,{npi_Base_gk	}'	,keynames(pversion,pUseProd).npi_group_key		,npi_group_key	 );
	tools.mac_FilesIndex('npi_base		,{npi_num		}	  ,{npi_Base_npi}'	,keynames(pversion,pUseProd).npi_npi_num		,npi_npi_num	 );

	// medschool keys - group_key
	tools.mac_FilesIndex('medschool_base		,{group_key	}	  ,{med_Base_gk	}'	,keynames(pversion,pUseProd).medschool_group_key		,medschool_group_key	 );
	
	// tax_codes keys - taxonomy
	tools.mac_FilesIndex('tax_codes_base		,{taxonomy	}	  ,{tax_codes_Base_tax	}'	,keynames(pversion,pUseProd).tax_codes_taxonomy		,tax_codes_taxonomy	 );

	// prov_ssn keys - group_key, ssn
	tools.mac_FilesIndex('prov_ssn_base		,{group_key	}	  ,{prov_ssn_Base_gk	}'	,keynames(pversion,pUseProd).prov_ssn_group_key		,prov_ssn_group_key	 );
	tools.mac_FilesIndex('prov_ssn_base(ssn<>\'\')		,{ssn				}	  ,{prov_ssn_Base_ssn	}'	,keynames(pversion,pUseProd).prov_ssn_ssn		,prov_ssn_ssn	 );

	// prov_birthdate keys - group_key
	tools.mac_FilesIndex('prov_birthdate_base		,{group_key	}	  ,{prov_birth_Base_gk	}'	,keynames(pversion,pUseProd).prov_birthdate_group_key		,prov_birthdate_group_key	 );
	
	// sanction keys - group_key
	tools.mac_FilesIndex('sanction_base		,{group_key	}	  ,{sanc_Base_gk	}'	,keynames(pversion,pUseProd).sanction_group_key		,sanction_group_key	 );
		
	// sanc_codes keys - sanc_code
	tools.mac_FilesIndex('sanc_codes_base		,{sanc_code	}	  ,{sanc_codes_Base_code	}'	,keynames(pversion,pUseProd).sanc_codes_sanc_codes		,sanc_codes_sanc_codes	 );
	
	// sanc_prov_type keys - sanc_prov_type_code
	tools.mac_FilesIndex('sanc_prov_type_base		,{prov_type_code	}	  ,{sanc_prov_type_Base	}'	,keynames(pversion,pUseProd).sanc_prov_type_sanc_prov_type_code		,sanc_prov_type_sanc_prov_type_code	 );

	//specialty keys - group_key+spec_code, spec_desc+group_key
	tools.mac_FilesIndex('specialty_base		,{group_key,spec_code	}	  ,{specialty_Base_gk	}'	,keynames(pversion,pUseProd).specialty_group_key_spec_code		,specialty_group_key_spec_code	 );
	tools.mac_FilesIndex('specialty_base		,{spec_desc,group_key	}	  ,{specialty_Base_gk	}'	,keynames(pversion,pUseProd).specialty_spec_desc_group_key		,specialty_spec_desc_group_key	 );
			
	
end;