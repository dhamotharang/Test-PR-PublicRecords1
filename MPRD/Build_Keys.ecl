import doxie, VersionControl, MPRD;

export Build_Keys := module
   
	export Build_Keys_facility_joined(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).facility_join_group_key.New		,Buildfacilityjoinedgroup);
				
				shared full_build :=
					sequential(
						Buildfacilityjoinedgroup,
						MPRD.Promote.Promote_facility_joined_grpkey(pversion,pUseProd).buildfiles.New2Built);
		
				export facility_joined_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping facility keys atribute'));
	end;

	export Build_Keys_facility_joined_filecode(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).facility_join_filecode_key.New		,Buildfacilityjoinedfilecode);
																		  
				shared full_build :=
					sequential(
						Buildfacilityjoinedfilecode,
						MPRD.Promote.Promote_facility_joined_filecodekey(pversion,pUseProd).buildfiles.New2Built);
		
				export facility_joined_filecode_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping facility keys atribute'));
	end;
	
	export Build_Keys_facility(string pversion, boolean pUseProd = false)	:= module
	
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).facility_lnpid.New	,Buildfacilitylnpid);
				
				shared full_build	:=
					sequential(
						Buildfacilitylnpid,
						MPRD.Promote.promote_facility(pversion,pUseProd).buildfiles.New2Built);
						
				export facility_all	:=
						if(VersionControl.IsValidVersion(pversion)
						,full_build
						,output('No Valid version parameter passed, skipping facility keys attribute'));
	end;
	
	export Build_Keys_individual_joined(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).individual_join_group_key.New		,BuildIndividualjoinedgroup);
				
				shared full_build :=
					sequential(
						BuildIndividualjoinedgroup,
						MPRD.Promote.Promote_individual_joined_grpkey(pversion,pUseProd).buildfiles.New2Built);
		
				export individual_joined_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys attribute'));
	end;
	
	export Build_keys_individual(string pversion, boolean pUseProd = false) := module
		
				VersionControl.macBuildNewLogicalKey(MPRD.keys(pversion,pUseProd).individual_lnpid.New ,BuildIndividuallnpid);
				
				shared full_build	:=
					sequential(
						BuildIndividuallnpid,
						MPRD.Promote.promote_individual(pversion,pUseProd).buildfiles.New2Built);
						
				export individual_all :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys attribute'));
		
	end;
	
	export Build_Keys_basc_cp(string pversion, boolean pUseProd = false) := module
				
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).basc_cp_group_key.New		,Buildbasc_cpGroup	);
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).basc_cp_lnpid.New				,Buildbasc_cplnpid);
																			  
				shared full_build :=
					sequential(
						Buildbasc_cpGroup,
						Buildbasc_cplnpid,
						MPRD.Promote.promote_basc_cp(pversion,pUseProd).buildfiles.New2Built);
		
				export basc_cp_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping basc_cp keys atribute'));
	end;
	
	export Build_Keys_basc_claims(string pversion, boolean pUseProd = false) := module
				
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).basc_claims_group_key.New		,Buildbasc_claimsGroup	);
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).basc_claims_lnpid.New				,Buildbasc_claimslnpid	);
																			  
				shared full_build :=
					sequential(
						Buildbasc_claimsGroup,
						Buildbasc_claimslnpid,
						MPRD.Promote.promote_basc_claims(pversion,pUseProd).buildfiles.New2Built);
		
				export basc_claims_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping basc_claims keys atribute'));
	end;
	
	export Build_Keys_npi_extension(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).npi_extension_npi_num_key.New		,BuildNpiExtensionNpiNumkey	);
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).npi_extension_lnpid.New					,BuildNpiExtensionlnpid			);
																	  
				shared full_build :=
					sequential(
						BuildNpiExtensionNpiNumkey,
						BuildNpiExtensionlnpid,
						MPRD.Promote.promote_npi_extension(pversion,pUseProd).buildfiles.New2Built);
		
				export npi_extension_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute'));
	end;
	
	export Build_Keys_npi_extension_facility(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).npi_extension_facility_npi_num_key.New		,BuildNpiExtensionfacilityNpiNumkey	);
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).npi_extension_facility_lnpid.New					,BuildNpiExtensionfacilitylnpid			);
																	  
				shared full_build :=
					sequential(
						BuildNpiExtensionfacilityNpiNumkey,
						BuildNpiExtensionfacilitylnpid,
						MPRD.Promote.promote_npi_extension_facility(pversion,pUseProd).buildfiles.New2Built
					);
		
				export npi_extension_facility_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute')
					);
	end;

	export Build_Keys_npi_tin_xref(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).npi_tin_xref_bill_npi_key.New		,Buildnpitinxrefbilltinkey);
																	  
				shared full_build :=
					sequential(
						Buildnpitinxrefbilltinkey,
						MPRD.Promote.promote_npi_tin_xref(pversion,pUseProd).buildfiles.New2Built);
		
				export npi_tin_xref_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute'));
	end;
	
	export Build_Keys_basc_deceased(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).basc_deceased_group_key.New		,Buildbascdeceasedgroupkey);
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).basc_deceased_lnpid.New				,Buildbascdeceasedlnpid		);
																	  
				shared full_build :=
					sequential(
						Buildbascdeceasedgroupkey,
						Buildbascdeceasedlnpid,
						MPRD.Promote.promote_basc_deceased(pversion,pUseProd).buildfiles.New2Built);
		
				export basc_deceased_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping basc deceased keys atribute'));
	end;
  
	export Build_Keys_claims_addr_master(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).claims_addr_master_bill_tin_key.New,			Buildclaimsaddrmasterbilltinkey			);
        VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).claims_addr_master_bill_npi_key.New,			Buildclaimsaddrmasterbillnpikey			);				
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).claims_addr_master_rendering_npi_key.New,	Buildclaimsaddrmasterrenderingnpikey);				
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).claims_addr_master_addr_key_key.New,			Buildclaimsaddrmasteraddrkeykey			);
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).claims_addr_master_lnpid.New,							Buildclaimsaddrmasterlnpid					);
																			  
				shared full_build :=
					sequential(
						Buildclaimsaddrmasterbilltinkey,
						Buildclaimsaddrmasterbillnpikey,
						Buildclaimsaddrmasterrenderingnpikey,
						Buildclaimsaddrmasteraddrkeykey,
						Buildclaimsaddrmasterlnpid,
						MPRD.Promote.promote_claims_addr_master(pversion,pUseProd).buildfiles.New2Built
					);
		
				export claims_addr_master_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping claims_addr_master keys atribute')
					);
	end;

	export Build_Keys_taxonomy_full_lu(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).taxonomy_full_lu_taxonomy_key.New		,Buildtaxonomyfulllutaxonomykey);
																	  
				shared full_build :=
					sequential(
						Buildtaxonomyfulllutaxonomykey,
						MPRD.Promote.promote_taxonomy_full_lu(pversion,pUseProd).buildfiles.New2Built);
		
				export taxonomy_full_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping client Data keys atribute'));
	end;
	
	export Build_Keys_specialty_lu(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).specialty_lu_specialty_key.New		,Buildspecialtyluspecialtykey);
																	  
				shared full_build :=
					sequential(
						Buildspecialtyluspecialtykey,
						MPRD.Promote.promote_specialty_lu(pversion,pUseProd).buildfiles.New2Built);
		
				export specialty_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping specialty_lu keys atribute'));
	end;
	
	export Build_Keys_group_lu(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).group_lu_code_key.New		,Buildgrouplucodekey);
																	  
				shared full_build :=
					sequential(
						Buildgrouplucodekey,
						MPRD.Promote.promote_group_lu(pversion,pUseProd).buildfiles.New2Built
					);
		
				export group_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping group_lu keys atribute'));
	end;
	
	export Build_Keys_hospital_lu(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).hospital_lu_code_key.New		,Buildhospitallucodekey);
																	  
				shared full_build :=
					sequential(
						Buildhospitallucodekey,
						MPRD.Promote.promote_hospital_lu(pversion,pUseProd).buildfiles.New2Built);
		
				export hospital_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping hospital_lu keys atribute'));
	end;
	
	export Build_Keys_best_hospital(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).best_hospital_addr_key.New		,Buildbesthospitaladdrkey);
																	  
				shared full_build :=
					sequential(
						Buildbesthospitaladdrkey,
						MPRD.Promote.promote_best_hospital(pversion,pUseProd).buildfiles.New2Built);
		
				export best_hospital_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping best_hospital keys atribute'));
	end;
		
	export Build_Keys_source_confidence_lu(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).source_confidence_lu_file_code_key.New		,Buildsourceconfidencelufilecodekey);
																	  
				shared full_build :=
					sequential(
						Buildsourceconfidencelufilecodekey,
						MPRD.Promote.promote_source_confidence_lu(pversion,pUseProd).buildfiles.New2Built);
		
				export source_confidence_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping source_confidence_lu keys atribute'));
	end;
	
	export Build_Keys_office_attributes_facility(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).office_attributes_facility_surrogate_key.New		,Buildofficeattributesfacilitysurrogatekey);
																	  
				shared full_build :=
					sequential(
						Buildofficeattributesfacilitysurrogatekey,
						MPRD.Promote.promote_office_attributes_facility(pversion,pUseProd).buildfiles.New2Built);
		
				export office_attributes_facility_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping office_attributes_facility keys atribute'));
	end;
	
	export Build_Keys_taxonomy_equiv(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).taxonomy_equiv_taxonomy_key.New		,Buildtaxonomyequivtaxonkey);
																	  
				shared full_build :=
					sequential(
						Buildtaxonomyequivtaxonkey,
						MPRD.Promote.promote_taxonomy_equiv(pversion,pUseProd).buildfiles.New2Built);
		
				export taxonomy_equiv_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping taxonomy_equiv keys atribute'));
	end;

	export Build_Keys_office_attributes(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).office_attributes_surrogate_key.New		,Buildofficeattributessurrogatekey);
																	  
				shared full_build :=
					sequential(
						Buildofficeattributessurrogatekey,
						MPRD.Promote.promote_office_attributes(pversion,pUseProd).buildfiles.New2Built);
		
				export office_attributes_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping office_attributes keys atribute'));
	end;
	
	export Build_Keys_lic_filedate(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).lic_filedate_filecode_key.New		,Buildlic_filedate_filecode_key);
																	  
				shared full_build :=
					sequential(
						Buildlic_filedate_filecode_key,
						MPRD.Promote.Promote_lic_filedate(pversion,pUseProd).buildfiles.New2Built);
		
				export lic_filedate_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping lic_filedate keys atribute'));
	end;
	
	export Build_Keys_group_practice(string pversion, boolean pUseProd = false) := module
	
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).group_practice_prac1_key_key.New	,Buildgroup_practice_prac1_key_key	);
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).group_practice_prac_phone1_key.New,Buildgroup_practice_prac_phone1_key);
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).group_practice_lnpid.New					,Buildgroup_practice_lnpid					);
				
				shared full_build	:=
					sequential(
						Buildgroup_practice_prac1_key_key,
						Buildgroup_practice_prac_phone1_key,
						Buildgroup_practice_lnpid,
						MPRD.Promote.Promote_group_practice(pversion,pUseProd).buildfiles.New2Built);
						
				export group_practice_all	:=
					if(VersionControl.IsValidVersion(pversion)
						,full_build
						,output('No Valid version parameter passed, skipping group_practice keys attribute'));
	end;
	
	export Build_Keys_opi(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).opi_npi_key.New		,Buildopi_npi_key);
																	  
				shared full_build :=
					sequential(
						Buildopi_npi_key,
						MPRD.Promote.Promote_opi(pversion,pUseProd).buildfiles.New2Built);
		
				export opi_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping opi_npi keys atribute'));
	end;
	
	export Build_Keys_opi_facility(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).opi_facility_npi_key.New		,Buildopi_facility_npi_key);
																	  
				shared full_build :=
					sequential(
						Buildopi_facility_npi_key,
						MPRD.Promote.Promote_opi_facility(pversion,pUseProd).buildfiles.New2Built);
		
				export opi_facility_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping opi_facility_npi keys attribute'));
	end;
	
	export Build_Keys_business_activities_lu(string pversion, boolean pUseProd = false)	:= module
	
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).business_activities_lu_ind_key.New	,Buildbusiness_activities_lu_ind_key);
				
				shared full_build	:=
					sequential(
						Buildbusiness_activities_lu_ind_key,
						MPRD.Promote.Promote_business_activities_lu(pversion,pUseProd).buildfiles.New2Built);
						
				export business_activities_lu_All	:=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping business_activities_lu_ind keys attribute'));
	end;
	
	export Build_Keys_cms_ecp(string pversion, boolean pUseProd = false)	:= module
	
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).cms_ecp_seq_key.New	,Buildcms_ecp_seq_key	);
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).cms_ecp_lnpid.New		,Buildcms_ecp_lnpid		);
				
				shared full_build	:=
					sequential(
						Buildcms_ecp_seq_key,
						Buildcms_ecp_lnpid,
						MPRD.Promote.Promote_cms_ecp(pversion,pUseProd).buildfiles.New2Built);
						
				export cms_ecp_All	:=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping cms_ecp_seq keys attribute'));
	end;

	export Build_Keys_basc_facility_mme(string pversion, boolean pUseProd = false)	:= module
	
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).basc_facility_mme_group_key.New, Buildbasc_facility_mme_gk);
				
				shared full_build :=
					sequential(
						Buildbasc_facility_mme_gk,
						MPRD.Promote.Promote_basc_facility_mme(pversion,pUseProd).buildfiles.New2Built);
						
				export basc_facility_mme_all	:=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('Noo Vlid version parameter passed, skipping basc_facility_mme_gk keys attribute'));
	end;
	
	export Build_Keys_claims_by_month(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).claims_by_month_bill_tin_key.New,					Buildclaimsbymonthbilltinkey);
        VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).claims_by_month_bill_npi_key.New,					Buildclaimsbymonthbillnpikey);				
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).claims_by_month_rendering_npi_key.New,Buildclaimsbymonthrenderingnpikey);				
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).claims_by_month_addr_key_key.New,			Buildclaimsbymonthaddrkeykey);
																			  
				shared full_build :=
					sequential(
						Buildclaimsbymonthbilltinkey,
						Buildclaimsbymonthbillnpikey,
						Buildclaimsbymonthrenderingnpikey,
						Buildclaimsbymonthaddrkeykey,
						MPRD.Promote.promote_claims_by_month(pversion,pUseProd).buildfiles.New2Built
					);
		
				export claims_by_month_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping claims_by_month keys atribute')
					);
	end;

	export Build_Keys_nanpa(string pversion, boolean pUseProd = false)	:= module
	
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).nanpa_npa_num_key.New, Buildnanpa_npa_key);
				
				shared full_build :=
					sequential(
						Buildnanpa_npa_key,
						MPRD.Promote.Promote_nanpa(pversion,pUseProd).buildfiles.New2Built);
						
				export nanpa_npa_all	:=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping nanpa_npa keys attribute'));
	end;
	
	export Build_Keys_client_data(string pversion, boolean pUseProd = false)	:= module
	
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).client_data_lnpid.New	,Buildclientdatalnpid);
				
				shared full_build	:=
					sequential(
						Buildclientdatalnpid,
						MPRD.Promote.Promote_client_data(pversion,pUseProd).buildfiles.New2Built);
						
				export client_data_all	:=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping client_data keys attribute'));
	end;
	
	export Build_Keys_basc_addr(string pversion, boolean pUseProd = false)	:= module
	
				VersionControl.macBuildNewLogicalKey(MPRD.Keys(pversion,pUseProd).basc_addr_lnpid.New	,Buildbascaddrlnpid);
				
				shared full_build	:=
					sequential(
						Buildbascaddrlnpid,
						MPRD.Promote.Promote_basc_addr(pversion,pUseProd).buildfiles.New2Built);
						
				export basc_addr_all	:=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping basc_addr keys attribute'));
		
	end;

end;