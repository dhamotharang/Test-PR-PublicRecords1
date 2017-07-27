// EXPORT Build_Keys_w_medschool := 'todo';
import doxie, VersionControl;

export Build_Keys_w_medschool := module
   
   	// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Did.New		,BuildDidKey	);
   																		  
   	// export full_build :=
   	// sequential(
   		 
   			// BuildDidKey
   		 
   		// ,Promote(pversion,pUseProd).buildfiles.New2Built
   	// );
   		
   	// export All :=
   	// if(VersionControl.IsValidVersion(pversion)
   		// ,full_build
   		// ,output('No Valid version parameter passed, skipping AlloyMediaConsumer.Build_Keys atribute')
   	// );
   
   // end;

/*export Build_Keys_facility(string pversion, boolean pUseProd = false) := module

				// facility keys - group_key and addr_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).facility_group_key.New		,BuildFacilityGroup	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).facility_surrogate_key.New		,Buildfacilitysurrogate);
			//	VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).facility_addr_key.New		,BuildFacilityAddr	);
															  
				shared full_build :=
					sequential(
						BuildFacilityGroup,
						Buildfacilitysurrogate,
						Promote.promote_facility(pversion,pUseProd).buildfiles.New2Built
					);
		
				export Facility_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping facility keys atribute')
					);
	end; */


export Build_Keys_facility_joined(string pversion, boolean pUseProd = false) := module

				// facility keys - group_key, lnpid
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).facility_join_group_key.New		,Buildfacilityjoinedgroup);
				
															  
				shared full_build :=
					sequential(
						Buildfacilityjoinedgroup,
						Promote.Promote_facility_joined_grpkey(pversion,pUseProd).buildfiles.New2Built
					);
		
				export facility_joined_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping facility keys atribute')
					);
	end;


export Build_Keys_facility_joined_filecode(string pversion, boolean pUseProd = false) := module

				// facility keys - group_key, lnpid
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).facility_join_filecode_key.New		,Buildfacilityjoinedfilecode);
				
															  
				shared full_build :=
					sequential(
						Buildfacilityjoinedfilecode,
						Promote.Promote_facility_joined_filecodekey(pversion,pUseProd).buildfiles.New2Built
					);
		
				export facility_joined_filecode_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping facility keys atribute')
					);
	end;

/*
	export Build_Keys_individual(string pversion, boolean pUseProd = false) := module

				// individual keys - group_key, lnpid
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).individual_group_key.New		,BuildIndividualGroup	);
				//VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).individual_lnpid.New		,BuildIndividualLNpid	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).individual_surrogate_key.New		,BuildIndividualsurrogate);
				
															  
				shared full_build :=
					sequential(
						BuildIndividualGroup,
						//BuildIndividualLNpid,
						BuildIndividualsurrogate,
						Promote.promote_individual(pversion,pUseProd).buildfiles.New2Built
					);
		
				export Individual_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute')
					);
	end; */
	
	export Build_Keys_individual_joined(string pversion, boolean pUseProd = false) := module

				// individual keys - group_key, lnpid
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).individual_join_group_key.New		,BuildIndividualjoinedgroup);
				
															  
				shared full_build :=
					sequential(
						BuildIndividualjoinedgroup,
						Promote.Promote_individual_joined_grpkey(pversion,pUseProd).buildfiles.New2Built
					);
		
				export individual_joined_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute')
					);
	end;
	
	
	
		export Build_Keys_basc_cp(string pversion, boolean pUseProd = false) := module
				
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).basc_cp_group_key.New		,Buildbasc_cpGroup	);
				//VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).basc_cp_lnpid.New		,Buildbasc_cpLNpid	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).basc_cp_surrogate_key.New		,Buildbasc_cpsurrogate);
				
															  
				shared full_build :=
					sequential(
						Buildbasc_cpGroup,
					//	Buildbasc_cpLNpid,
						// Buildbasc_cpsurrogate,
						Promote.promote_basc_cp(pversion,pUseProd).buildfiles.New2Built
					);
		
				export basc_cp_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping basc_cp keys atribute')
					);
	end;
	
	
	
	export Build_Keys_basc_claims(string pversion, boolean pUseProd = false) := module
				
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).basc_claims_group_key.New		,Buildbasc_claimsGroup	);
			//	VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).basc_claims_lnpid.New		,Buildbasc_claimsLNpid	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).basc_claims_surrogate_key.New		,Buildbasc_claimssurrogate);
				
															  
				shared full_build :=
					sequential(
						Buildbasc_claimsGroup,
				//		Buildbasc_claimsLNpid,
						// Buildbasc_claimssurrogate,
						Promote.promote_basc_claims(pversion,pUseProd).buildfiles.New2Built
					);
		
				export basc_claims_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping basc_claims keys atribute')
					);
	end;
	
	
	export Build_Keys_npi_extension(string pversion, boolean pUseProd = false) := module

				// npi_extension keys - npi_num_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).npi_extension_npi_num_key.New		,BuildNpiExtensionNpiNumkey);
																	  
				shared full_build :=
					sequential(
						BuildNpiExtensionNpiNumkey,
						Promote.promote_npi_extension(pversion,pUseProd).buildfiles.New2Built
					);
		
				export npi_extension_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute')
					);
	end;
	
	
		export Build_Keys_npi_extension_facility(string pversion, boolean pUseProd = false) := module

				// npi_extension_facility keys - npi_num_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).npi_extension_facility_npi_num_key.New		,BuildNpiExtensionfacilityNpiNumkey);
																	  
				shared full_build :=
					sequential(
						BuildNpiExtensionfacilityNpiNumkey,
						Promote.promote_npi_extension_facility(pversion,pUseProd).buildfiles.New2Built
					);
		
				export npi_extension_facility_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute')
					);
	end;
	
/*	
		export Build_Keys_claims_addr_master(string pversion, boolean pUseProd = false) := module

				// claims_addr_master keys - npi_num_key
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).claims_addr_master_bill_tin_key.New		,Buildclaimsaddrmasterbilltinkey);
        // VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).claims_addr_master_bill_npi_key.New		,Buildclaimsaddrmasterbillnpikey);				
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).claims_addr_master_rendering_npi_key.New		,Buildclaimsaddrmasterrenderingnpikey);				
				
																	  
				shared full_build :=
					sequential(
						// Buildclaimsaddrmasterbilltinkey,
						// Buildclaimsaddrmasterbillnpikey,
						Buildclaimsaddrmasterrenderingnpikey,
						Promote.promote_claims_addr_master(pversion,pUseProd).buildfiles.New2Built
					);
		
				export claims_addr_master_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute')
					);
	end; */
	
/*	
		export Build_Keys_claims_by_month(string pversion, boolean pUseProd = false) := module

				// claims_by_month keys - bill_tin key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).claims_by_month_bill_tin_key.New		,Buildclaimsbymonthbilltinkey);
																	  
				shared full_build :=
					sequential(
						Buildclaimsbymonthbilltinkey,
						Promote.promote_claims_by_month(pversion,pUseProd).buildfiles.New2Built
					);
		
				export claims_by_month_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping claims_by_month keys atribute')
					);
	end; */
	
	export Build_Keys_npi_tin_xref(string pversion, boolean pUseProd = false) := module

				// npi_tin_xref keys - npi_num_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).npi_tin_xref_bill_npi_key.New		,Buildnpitinxrefbilltinkey);
																	  
				shared full_build :=
					sequential(
						Buildnpitinxrefbilltinkey,
						Promote.promote_npi_tin_xref(pversion,pUseProd).buildfiles.New2Built
					);
		
				export npi_tin_xref_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute')
					);
	end;
	
	export Build_Keys_taxonomy_equiv(string pversion, boolean pUseProd = false) := module

				// taxonomy_equiv keys - npi_num_key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).taxonomy_equiv_taxonomy_key.New		,Buildtaxonomyequivtaxonkey);
																	  
				shared full_build :=
					sequential(
						Buildtaxonomyequivtaxonkey,
						Promote.promote_taxonomy_equiv(pversion,pUseProd).buildfiles.New2Built
					);
		
				export taxonomy_equiv_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping individual keys atribute')
					);
	end;
	
	export Build_Keys_basc_deceased(string pversion, boolean pUseProd = false) := module

				// basc_deceased  keys - groupkey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).basc_deceased_group_key.New		,Buildbascdeceasedgroupkey);
																	  
				shared full_build :=
					sequential(
						Buildbascdeceasedgroupkey,
						Promote.promote_basc_deceased(pversion,pUseProd).buildfiles.New2Built
					);
		
				export basc_deceased_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping basc deceased keys atribute')
					);
	end;
 /* 
	export Build_Keys_basc_addr(string pversion, boolean pUseProd = false) := module

				// basc_addr  keys - groupkey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).basc_addr_surrogate_key.New		,Buildbascaddrsurrogatekey);
																	  
				shared full_build :=
					sequential(
						Buildbascaddrsurrogatekey,
						Promote.promote_basc_addr(pversion,pUseProd).buildfiles.New2Built
					);
		
				export basc_addr_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping basc addr keys atribute')
					);
	end; */
	/*
	export Build_Keys_client_Data(string pversion, boolean pUseProd = false) := module

				// client_Data  keys - surrogatekey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).client_Data_surrogate_key.New		,Buildclientdatasurrogatekey);
																	  
				shared full_build :=
					sequential(
						Buildclientdatasurrogatekey,
						Promote.promote_client_Data(pversion,pUseProd).buildfiles.New2Built
					);
		
				export client_Data_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping client Data keys atribute')
					);
	end; */
	/*
	export Build_Keys_std_terms_lu(string pversion, boolean pUseProd = false) := module

				//std_terms  keys - codekey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).std_terms_lu_code_key.New		,Buildstdtermslucodekey);
																	  
				shared full_build :=
					sequential(
						Buildstdtermslucodekey,
						Promote.promote_std_terms_lu(pversion,pUseProd).buildfiles.New2Built
					);
		
				export std_terms_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping client Data keys atribute')
					);
	end; */
	
			export Build_Keys_taxonomy_full_lu(string pversion, boolean pUseProd = false) := module

				// taxonomy_full_lu  keys - taxonomykey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).taxonomy_full_lu_taxonomy_key.New		,Buildtaxonomyfulllutaxonomykey);
																	  
				shared full_build :=
					sequential(
						Buildtaxonomyfulllutaxonomykey,
						Promote.promote_taxonomy_full_lu(pversion,pUseProd).buildfiles.New2Built
					);
		
				export taxonomy_full_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping client Data keys atribute')
					);
	end;
	
	export Build_Keys_specialty_lu(string pversion, boolean pUseProd = false) := module

				// specialty_lu  keys - specialtykey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).specialty_lu_specialty_key.New		,Buildspecialtyluspecialtykey);
																	  
				shared full_build :=
					sequential(
						Buildspecialtyluspecialtykey,
						Promote.promote_specialty_lu(pversion,pUseProd).buildfiles.New2Built
					);
		
				export specialty_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping specialty_lu keys atribute')
					);
	end;
	
		export Build_Keys_group_lu(string pversion, boolean pUseProd = false) := module

				//group_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).group_lu_code_key.New		,Buildgrouplucodekey);
																	  
				shared full_build :=
					sequential(
						Buildgrouplucodekey,
						Promote.promote_group_lu(pversion,pUseProd).buildfiles.New2Built
					);
		
				export group_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping group_lu keys atribute')
					);
	end;
	
			export Build_Keys_hospital_lu(string pversion, boolean pUseProd = false) := module

				//hospital_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).hospital_lu_code_key.New		,Buildhospitallucodekey);
																	  
				shared full_build :=
					sequential(
						Buildhospitallucodekey,
						Promote.promote_hospital_lu(pversion,pUseProd).buildfiles.New2Built
					);
		
				export hospital_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping hospital_lu keys atribute')
					);
	end;
	/*
		export Build_Keys_dea_xref(string pversion, boolean pUseProd = false) := module

				// dea_xref  keys - groupkey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).dea_xref_group_key.New		,Builddeaxrefgroupkey);
																	  
				shared full_build :=
					sequential(
						Builddeaxrefgroupkey,
						Promote.promote_dea_xref(pversion,pUseProd).buildfiles.New2Built
					);
		
				export dea_xref_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping dea_xref keys atribute')
					);
	end; */
	
	/*
			export Build_Keys_lic_xref(string pversion, boolean pUseProd = false) := module

				// lic_xref  keys - groupkey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).lic_xref_group_key.New		,Buildlicxrefgroupkey);
																	  
				shared full_build :=
					sequential(
						Buildlicxrefgroupkey,
						Promote.promote_lic_xref(pversion,pUseProd).buildfiles.New2Built
					);
		
				export lic_xref_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping lic_xref keys atribute')
					);
	end; */
	/*
			export Build_Keys_facility_name_xref(string pversion, boolean pUseProd = false) := module

				// facility_name_xref  keys - taxonomy
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).facility_name_xref_taxonomy_key.New		,Buildfacilitynamexreftaxonomykey);
																	  
				shared full_build :=
					sequential(
						Buildfacilitynamexreftaxonomykey,
						Promote.promote_facility_name_xref(pversion,pUseProd).buildfiles.New2Built
					);
		
				export facility_name_xref_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping facility_name_xref keys atribute')
					);
	end; */
	/*
		export Build_Keys_addr_name_xref(string pversion, boolean pUseProd = false) := module

				// addr_name_xref  keys - taxonomy
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).addr_name_xref_group_key.New		,Buildaddrnamexrefgroupkey);
																	  
				shared full_build :=
					sequential(
						Buildaddrnamexrefgroupkey,
						Promote.promote_addr_name_xref(pversion,pUseProd).buildfiles.New2Built
					);
		
				export addr_name_xref_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping addr_name_xref keys atribute')
					);
	end; */
		/*	
			export Build_Keys_basc_facility_mme(string pversion, boolean pUseProd = false) := module

				// basc_facility_mme  keys - group
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).basc_facility_mme_group_key.New		,Buildbascfacilitymmegroupkey);
																	  
				shared full_build :=
					sequential(
						Buildbascfacilitymmegroupkey,
						Promote.promote_basc_facility_mme(pversion,pUseProd).buildfiles.New2Built
					);
		
				export basc_facility_mme_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping basc_facility_mme keys atribute')
					);
	end; */
	/*
	export Build_Keys_nanpa(string pversion, boolean pUseProd = false) := module

				// nanpa  keys - npa_num
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).nanpa_npa_num_key.New		,Buildnanpanpanumkey);
																	  
				shared full_build :=
					sequential(
						Buildnanpanpanumkey,
						Promote.promote_nanpa(pversion,pUseProd).buildfiles.New2Built
					);
		
				export nanpa_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping nanpa keys atribute')
					);
	end; */
	
			export Build_Keys_best_hospital(string pversion, boolean pUseProd = false) := module

				// best_hospital  keys - addr
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).best_hospital_addr_key.New		,Buildbesthospitaladdrkey);
																	  
				shared full_build :=
					sequential(
						Buildbesthospitaladdrkey,
						Promote.promote_best_hospital(pversion,pUseProd).buildfiles.New2Built
					);
		
				export best_hospital_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping best_hospital keys atribute')
					);
	end;
	/*
		export Build_Keys_last_name_stats(string pversion, boolean pUseProd = false) := module

				// last_name_stats  keys - lastname
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).last_name_stats_last_name_key.New		,Buildlastnamestatslastnamekey);
																	  
				shared full_build :=
					sequential(
						Buildlastnamestatslastnamekey,
						Promote.promote_last_name_stats(pversion,pUseProd).buildfiles.New2Built
					);
		
				export last_name_stats_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping last_name_stats keys atribute')
					);
	end; */
	
		export Build_Keys_source_confidence_lu(string pversion, boolean pUseProd = false) := module

				// source_confidence_lu  keys - filecode
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).source_confidence_lu_file_code_key.New		,Buildsourceconfidencelufilecodekey);
																	  
				shared full_build :=
					sequential(
						Buildsourceconfidencelufilecodekey,
						Promote.promote_source_confidence_lu(pversion,pUseProd).buildfiles.New2Built
					);
		
				export source_confidence_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping source_confidence_lu keys atribute')
					);
	end;
	
	export Build_Keys_office_attributes_facility(string pversion, boolean pUseProd = false) := module

				// office_attributes_facility  keys - surogate key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).office_attributes_facility_surrogate_key.New		,Buildofficeattributesfacilitysurrogatekey);
																	  
				shared full_build :=
					sequential(
						Buildofficeattributesfacilitysurrogatekey,
						Promote.promote_office_attributes_facility(pversion,pUseProd).buildfiles.New2Built
					);
		
				export office_attributes_facility_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping office_attributes_facility keys atribute')
					);
	end;
	
	
			export Build_Keys_office_attributes(string pversion, boolean pUseProd = false) := module

				// office_attributes  keys - surogate key
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).office_attributes_surrogate_key.New		,Buildofficeattributessurrogatekey);
																	  
				shared full_build :=
					sequential(
						Buildofficeattributessurrogatekey,
						Promote.promote_office_attributes(pversion,pUseProd).buildfiles.New2Built
					);
		
				export office_attributes_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping office_attributes keys atribute')
					);
	end;
	/*
			export Build_Keys_ignore_terms_lu (string pversion, boolean pUseProd = false) := module

				//ignore_term_lu   keys -code
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).ignore_terms_lu_code_key.New		,Buildignoretermslucodekey);
																	  
				shared full_build :=
					sequential(
						Buildignoretermslucodekey,
						Promote.Promote_ignore_terms_lu (pversion,pUseProd).buildfiles.New2Built
					);
		
				export ignore_terms_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping ignore_term_lu  keys atribute')
					);
	end; */
	
	/*
	
	export Build_Keys_taxon_lu(string pversion, boolean pUseProd = false) := module

				//taxon_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).taxon_lu_code_key.New		,Buildtaxonlucodekey);
																	  
				shared full_build :=
					sequential(
						Buildtaxonlucodekey,
						Promote.promote_taxon_lu(pversion,pUseProd).buildfiles.New2Built
					);
		
				export taxon_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping taxon_lu keys atribute')
					);
	end; */
	
	/*
	export Build_Keys_abbr_lu(string pversion, boolean pUseProd = false) := module

				//abbr_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).abbr_lu_code_key.New		,Buildabbrlucodekey);
																	  
				shared full_build :=
					sequential(
						Buildabbrlucodekey,
						Promote.promote_abbr_lu(pversion,pUseProd).buildfiles.New2Built
					);
		
				export abbr_lu_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping abbr_lu keys atribute')
					);
	end;*/
	
/*	
	export Build_Keys_call_queue_bad(string pversion, boolean pUseProd = false) := module

				//call_queue_bad_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).call_queue_bad_phone_key.New		,Buildcall_queue_badphonekey);
																	  
				shared full_build :=
					sequential(
						Buildcall_queue_badphonekey,
						Promote.promote_call_queue_bad(pversion,pUseProd).buildfiles.New2Built
					);
		
				export call_queue_bad_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping call_queue_bad_lu keys atribute')
					);
	end; */
	
	
		export Build_Keys_medschool(string pversion, boolean pUseProd = false) := module

				//call_queue_bad_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Keys_w_medschool(pversion,pUseProd).medschool_msid_key.New		,Buildmedschool_msid_key);
																	  
				shared full_build :=
					sequential(
						Buildmedschool_msid_key,
						Promote_w_medschool.promote_medschool(pversion,pUseProd).buildfiles.New2Built
					);
		
				export medschool_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping medschool  keys atribute')
					);
	end;


export Build_Keys_medschool_wordlist(string pversion, boolean pUseProd = false) := module

				//call_queue_bad_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Keys_w_medschool(pversion,pUseProd).medschool_wordlist_word_key.New		,Buildmedschool_wordlist_word_key);
																	  
				shared full_build :=
					sequential(
						Buildmedschool_wordlist_word_key,
						Promote_w_medschool.Promote_medschool_wordlist(pversion,pUseProd).buildfiles.New2Built
					);
		
				export medschool_wordlist_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping medschool wordlist keys atribute')
					);
	end;
	
	
	
		export Build_Keys_non_medschool(string pversion, boolean pUseProd = false) := module

				//call_queue_bad_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Keys_w_medschool(pversion,pUseProd).non_medschool_msid_key.New		,Buildnon_medschool_msid_key);
																	  
				shared full_build :=
					sequential(
						Buildnon_medschool_msid_key,
						Promote_w_medschool.promote_non_medschool(pversion,pUseProd).buildfiles.New2Built
					);
		
				export non_medschool_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping medschool  keys atribute')
					);
	end;


export Build_Keys_non_medschool_wordlist(string pversion, boolean pUseProd = false) := module

				//call_queue_bad_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Keys_w_medschool(pversion,pUseProd).non_medschool_wordlist_word_key.New		,Buildnon_medschool_wordlist_word_key);
																	  
				shared full_build :=
					sequential(
						Buildnon_medschool_wordlist_word_key,
						Promote_w_medschool.Promote_non_medschool_wordlist(pversion,pUseProd).buildfiles.New2Built
					);
		
				export non_medschool_wordlist_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping medschool wordlist keys atribute')
					);
	end;
	
	
	
	end;