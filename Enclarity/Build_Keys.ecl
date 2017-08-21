import doxie, VersionControl, AutoKeyB2, RoxieKeyBuild, ut, standard;

export Build_Keys := module

	export Build_Keys_facility(string pversion, boolean pUseProd = false) := module

				// facility keys - group_key and addr_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).facility_group_key.New		,BuildFacilityGroup	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).facility_addr_key.New		,BuildFacilityAddr	);
															  
				shared full_build :=
					sequential(
						BuildFacilityGroup,
						// BuildFacilityAddr,
						Promote.promote_facility(pversion,pUseProd).buildfiles.New2Built
					);
		
				export Facility_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping facility keys atribute')
					);
	end;

	export Build_Keys_individual(string pversion, boolean pUseProd = false) := module

				// individual keys - group_key, lnpid
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).individual_group_key.New		,BuildIndividualGroup	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).individual_lnpid.New		,BuildIndividualLNpid	);
															  
				shared full_build :=
					sequential(
						BuildIndividualGroup,
						BuildIndividualLNpid,
						Promote.promote_individual(pversion,pUseProd).buildfiles.New2Built
					);
		
				export Individual_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute')
					);
	end;
	
	export Build_Keys_associate(string pversion, boolean pUseProd = false) := module

			// associate keys - group_key, addr_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).associate_group_key.New		,BuildAssociateGroup	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).associate_addr_key.New		,BuildAssociateAddr	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).associate_bill_tin.New		,BuildAssociateBillTin	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).associate_bgk.New		,BuildAssociateBillGk	);
															  
				shared full_build :=
					sequential(
						BuildAssociateGroup,
						// BuildAssociateAddr,
						BuildAssociateBillTin,
						BuildAssociateBillGk,
						Promote.promote_associate(pversion,pUseProd).buildfiles.New2Built
					);
		
				export Associate_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping associate keys atribute')
					);
	end;
	
	export Build_Keys_address(string pversion, boolean pUseProd = false) := module

				// address keys - group_key, addr_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).address_group_key.New		,BuildAddressGroup	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).address_addr_key.New		,BuildAddressAddr	);
															  
				shared full_build :=
					sequential(
						BuildAddressGroup,
						BuildAddressAddr,
						Promote.promote_address(pversion,pUseProd).buildfiles.New2Built
					);
		
				export Address_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping address keys atribute')
					);
	end;
	export Build_Keys_dea(string pversion, boolean pUseProd = false) := module

				// dea keys - group_key, dea_num
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).dea_group_key.New		,BuildDeaGroup	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).dea_dea_num.New		,BuildDeaDeaNum	);
															  
				shared full_build :=
					sequential(
						BuildDeaGroup,
						BuildDeaDeaNum,
						Promote.promote_dea(pversion,pUseProd).buildfiles.New2Built
					);
		
				export Dea_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping DEA keys atribute')
					);
	end;
	export Build_Keys_license(string pversion, boolean pUseProd = false) := module

				// license keys - group_key, lic_num
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).license_group_key.New		,BuildLicenseGroup	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).license_lic_num.New		,BuildLicenseLicNum	);
															  
				shared full_build :=
					sequential(
						BuildLicenseGroup,
						// BuildLicenseLicNum,
						Promote.promote_license(pversion,pUseProd).buildfiles.New2Built
					);
		
				export License_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping license keys atribute')
					);
	end;
	export Build_Keys_taxonomy(string pversion, boolean pUseProd = false) := module

				// taxonomy keys - group_key, taxonomy
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).taxonomy_group_key.New		,BuildTaxonomyGroup	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).taxonomy_taxonomy.New		,BuildTaxonomyTaxonomy	);
															  
				shared full_build :=
					sequential(
						BuildTaxonomyGroup,
						// BuildTaxonomyTaxonomy,
						Promote.promote_taxonomy(pversion,pUseProd).buildfiles.New2Built
					);
		
				export Taxonomy_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping taxonomy keys atribute')
					);
	end;
	export Build_Keys_NPI(string pversion, boolean pUseProd = false) := module

				// npi keys - group_key, npi_num
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).NPI_group_key.New		,BuildNPIGroup	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).NPI_NPI_num.New		,BuildNpiNpiNum	);
															  
				shared full_build :=
					sequential(
						BuildNPIGroup,
						BuildNpiNpiNum,
						Promote.promote_NPI(pversion,pUseProd).buildfiles.New2Built
					);
		
				export NPI_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping NPI keys atribute')
					);
	end;
	export Build_Keys_medschool(string pversion, boolean pUseProd = false) := module

				// medschool keys - group_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).medschool_group_key.New		,BuildMedschoolGroup	);
															  
				shared full_build :=
					sequential(
						BuildMedschoolGroup,
						Promote.promote_medschool(pversion,pUseProd).buildfiles.New2Built
					);
		
				export medschool_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping medschool keys atribute')
					);
	end;
	export Build_Keys_tax_codes(string pversion, boolean pUseProd = false) := module

				// tax_codes keys - taxonomy
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).tax_codes_taxonomy.New		,BuildTaxCodesTaxonomy	);
															  
				shared full_build :=
					sequential(
						BuildTaxCodesTaxonomy,
						Promote.promote_tax_codes(pversion,pUseProd).buildfiles.New2Built
					);
		
				export tax_codes_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping tax_codes keys atribute')
					);
	end;
	export Build_Keys_prov_ssn(string pversion, boolean pUseProd = false) := module

				// prov_ssn keys - group_key, ssn
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).prov_ssn_group_key.New		,BuildProvSSNGroup	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).prov_ssn_ssn.New		,BuildProvSsnSsn	);
															  
				shared full_build :=
					sequential(
						BuildProvSSNGroup,
						BuildProvSsnSsn,
						Promote.promote_prov_ssn(pversion,pUseProd).buildfiles.New2Built
					);
		
				export prov_ssn_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping prov_ssn keys atribute')
					);
	end;
	export Build_Keys_prov_birthdate(string pversion, boolean pUseProd = false) := module

				// prov_birthdate keys - group_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).prov_birthdate_group_key.New		,BuildProvDOBGroup	);
															  
				shared full_build :=
					sequential(
						BuildProvDOBGroup,
						Promote.promote_prov_birthdate(pversion,pUseProd).buildfiles.New2Built
					);
		
				export prov_birthdate_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping prov_birthdate keys atribute')
					);
	end;
	export Build_Keys_sanction(string pversion, boolean pUseProd = false) := module

				// sanction keys - group_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).sanction_group_key.New		,BuildSanctionGroup	);
															  
				shared full_build :=
					sequential(
						BuildSanctionGroup,
						Promote.promote_sanction(pversion,pUseProd).buildfiles.New2Built
					);
		
				export sanction_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping sanction keys atribute')
					);
	end;
	export Build_Keys_sanc_codes(string pversion, boolean pUseProd = false) := module

				// sanc_codes keys - sanc_code
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).sanc_codes_sanc_codes.New		,BuildSancCodes	);
															  
				shared full_build :=
					sequential(
						BuildSancCodes,
						Promote.promote_sanc_codes(pversion,pUseProd).buildfiles.New2Built
					);
		
				export sanc_codes_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping sanc_codes keys atribute')
					);
	end;
	export Build_Keys_sanc_prov_type(string pversion, boolean pUseProd = false) := module

				// sanc_prov_type keys - sanc_prov_type_code
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).sanc_prov_type_sanc_prov_type_code.New		,BuildSancProvType	);
															  
				shared full_build :=
					sequential(
						BuildSancProvType,
						Promote.promote_sanc_prov_type(pversion,pUseProd).buildfiles.New2Built
					);
		
				export sanc_prov_type_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping sanc_prov_type keys atribute')
					);
	end;
	export Build_Keys_specialty(string pversion, boolean pUseProd = false) := module

				//specialty keys - group_key+spec_code, spec_desc+group_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).specialty_group_key_spec_code.New		,BuildSpecGroup	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).specialty_spec_desc_group_key.New		,BuildSpecDesc	);
															  
				shared full_build :=
					sequential(
						BuildSpecGroup,
						// BuildSpecDesc,
						Promote.promote_specialty(pversion,pUseProd).buildfiles.New2Built
					);
		
				export specialty_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping specialty keys atribute')
					);
	end;
	// export Build_Keys_dea_bacodes(string pversion, boolean pUseProd = false) := module

				//dea_bacodes keys - dea_bus_act_ind+dea_bus_act_ind_sub
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).dea_bacodes_dea_bus_act_ind.New		,BuildDeaBACodes	);
															  
				// shared full_build :=
					// sequential(
						// BuildDeaBACodes,
						// Promote.promote_dea_bacodes(pversion,pUseProd).buildfiles.New2Built
					// );
		
				// export dea_bacodes_All :=
					// if(VersionControl.IsValidVersion(pversion)
					// ,full_build
					// ,output('No Valid version parameter passed, skipping dea_bacodes keys atribute')
					// );
	// end;
	

	export Build_autokeys_individual(string pversion)	:= function
		c := autokey_constants(pversion).autokey_indiv_constants; 

		ak_keyname  := c.str_autokeyname;
		ak_logical  := c.ak_logical;

		base_ind	:= project(Enclarity.Files().individual_Base.built
																,transform(layouts.autokey_common
																	,self:=left
																	,self:=[]
																	));
		base_fac	:= project(Enclarity.Files().facility_Base.built
																,transform(layouts.autokey_common
																	,self:=left
																	,self:=[]
																	));

		ak_dataset  := base_ind + base_fac;

		ak_skipSet  := c.ak_skipSet;
		ak_typeStr  := c.ak_typeStr;

		AutoKeyB2.MAC_Build (ak_dataset,first_name,middle_name,last_name,
                     clean_ssn,
                     clean_dob,
                     blank,
                     prim_name,
                     prim_range,
                     st,
                     v_city_name,
                     zip,
                     sec_range,
                     zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,
                     did,
                     clean_company_name, // compname which is string thus "blank"
                     clean_ssn,
                     zero,
                     prim_name,prim_range,st,v_city_name,zip,sec_range,
                     bdid, // bdid_out
                     ak_keyname,
                     ak_logical,
                     BAK,false,
                     ak_skipSet,true,ak_typeStr,
                     true,,,zero);

		AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, MAK,, ak_skipSet);

		return sequential(
									BAK,
									MAK
									);
		end;
		
	export Build_autokeys_sanction(string pversion)	:= function
		c := autokey_constants(pversion).autokey_sanc_constants; 

		ak_keyname  := c.str_autokeyname;
		ak_logical  := c.ak_logical;

		base_ind	:= project(Enclarity.Files().individual_Base.built(sanc1_code<>'')
																,transform(layouts.autokey_common
																	,self:=left
																	,self:=[]
																	));
		base_fac	:= project(Enclarity.Files().facility_Base.built(sanc1_code<>'')
																,transform(layouts.autokey_common
																	,self:=left
																	,self:=[]
																	));

		ak_dataset  := base_ind + base_fac;

		ak_skipSet  := c.ak_skipSet;
		ak_typeStr  := c.ak_typeStr;

		AutoKeyB2.MAC_Build (ak_dataset,fname,mname,lname,
                     clean_ssn,
                     clean_dob,
                     blank,
                     prim_name,
                     prim_range,
                     st,
                     v_city_name,
                     zip,
                     sec_range,
                     zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,
                     did,
                     clean_company_name, // compname which is string thus "blank"
                     clean_ssn,
                     zero,
                     prim_name,prim_range,st,v_city_name,zip,sec_range,
                     bdid, // bdid_out
                     ak_keyname,
                     ak_logical,
                     BAK,false,
                     ak_skipSet,true,ak_typeStr,
                     true,,,zero);

		AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, MAK,, ak_skipSet);

		return sequential(
									BAK,
									MAK
									);
		end;
		
end;