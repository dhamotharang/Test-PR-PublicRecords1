import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote_w_medschool	:= module
export Promote_facility(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   =   3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).facility_base.dAll_filenames
																					+ keynames	(pversion,pUseProd).facility_group_key.dAll_filenames	// facility keys - group_key and addr_key
																					+ keynames  (pversion,pUseProd).facility_surrogate_key.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;
	
	export Promote_facility_joined_grpkey(
		string								pversion				= 	''
		,boolean							pUseProd			= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	keynames(pversion,pUseProd).facility_join_group_key.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;
	
	
	
	export Promote_facility_joined_filecodekey(
		string								pversion				= 	''
		,boolean							pUseProd			= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	keynames(pversion,pUseProd). facility_join_filecode_key.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;
	
	export Promote_individual(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   =   3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).individual_base.dAll_filenames
																					+ keynames	(pversion,pUseProd).individual_group_key.dAll_filenames	// individual keys - group_key, lnpid
																					+ keynames  (pversion,pUseProd).individual_surrogate_key.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;
	
		export Promote_individual_joined_grpkey(
		string								pversion				= 	''
		,boolean							pUseProd			= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	keynames(pversion,pUseProd).individual_join_group_key.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	end;
	
	export Promote_basc_cp(
		string								pversion				= 	''
		,boolean							pUseProd			  =   false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   =   3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).basc_cp_base.dAll_filenames
																					+ keynames	(pversion,pUseProd).basc_cp_group_key.dAll_filenames	// individual keys - group_key, lnpid
																					+ keynames  (pversion,pUseProd).basc_cp_surrogate_key.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;	
	
	
	
		export Promote_basc_claims(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   =   3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).basc_claims_base.dAll_filenames
																					+ keynames	(pversion,pUseProd).basc_claims_surrogate_key.dAll_filenames	// individual keys - group_key, lnpid
																					+ keynames  (pversion,pUseProd).basc_claims_group_key.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;	
	
export Promote_claims_by_month(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   =   3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).claims_by_month_base.dAll_filenames
																					  + keynames	(pversion,pUseProd).claims_by_month_bill_tin_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;	
	
export Promote_claims_addr_master(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   =   3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).claims_addr_master_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).claims_addr_master_bill_tin_key.dAll_filenames	// individual keys - group_key, lnpid
																					+ keynames  (pversion,pUseProd).claims_addr_master_bill_npi_key.dAll_filenames
																					+ keynames  (pversion,pUseProd).claims_addr_master_rendering_npi_key.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;	
	
	
	export Promote_npi_tin_xref(
		string								pversion				= 	''
		,boolean							pUseProd			= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations       = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).npi_tin_xref_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).npi_tin_xref_bill_npi_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;
	
		export Promote_npi_extension(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations       = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).npi_extension_Base.dAll_filenames
																					 + keynames	(pversion,pUseProd).npi_extension_npi_num_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;
	
	export Promote_npi_extension_facility(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).npi_extension_facility_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).npi_extension_facility_npi_num_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;
	
	
		export Promote_taxonomy_equiv(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).taxonomy_equiv_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).taxonomy_equiv_taxonomy_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	
	end;
	
	
		export Promote_basc_deceased(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).basc_deceased_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).basc_deceased_group_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
			
	end;		
			
		export Promote_basc_addr(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).basc_addr_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).basc_addr_surrogate_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
		
		
		export Promote_client_data(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).client_data_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).client_Data_surrogate_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
		  export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
	
	
		export Promote_office_attributes(
		string								pversion				= 	''
		,boolean							pUseProd		  	= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).office_attributes_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).office_attributes_surrogate_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
		
		export Promote_office_attributes_facility(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).office_attributes_facility_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).office_attributes_facility_surrogate_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
		
		
		
		export Promote_std_terms_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).std_terms_lu_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).std_terms_lu_code_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
		
		
		export Promote_taxonomy_full_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).taxonomy_full_lu_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).taxonomy_full_lu_taxonomy_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
			
		end;	
	 	
		export Promote_dir_confidence_2010_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).dir_confidence_2010_lu_Base.dAll_filenames
																					//+ keynames	(pversion,pUseProd).individual_group_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;		
		
		export Promote_specialty_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).specialty_lu_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).specialty_lu_specialty_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;		
		
   
   export Promote_group_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).group_lu_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).group_lu_code_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;		
		
		export Promote_hospital_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).hospital_lu_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).hospital_lu_code_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;		
    
		export Promote_dea_xref(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).dea_xref_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).dea_xref_group_key.dAll_filenames// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;		
		
		export Promote_lic_xref(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).lic_xref_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).lic_xref_group_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;	
		
		export Promote_addr_name_xref(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).addr_name_xref_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).addr_name_xref_group_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;	
		
		
		export Promote_facility_name_xref(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).facility_name_xref_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).facility_name_xref_taxonomy_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;	
		
		export Promote_basc_facility_mme(
		string								pversion				= 	''
		,boolean							pUseProd			= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).basc_facility_mme_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).basc_facility_mme_group_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;	
		
		
		export Promote_lic_filedate(
		string								pversion				= 	''
		,boolean							pUseProd			= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).lic_filedate_Base.dAll_filenames
																					//+ keynames	(pversion,pUseProd).individual_group_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;	
		
		export Promote_nanpa(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).nanpa_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).nanpa_npa_num_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;	
		
		
		
		export Promote_best_hospital(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).best_hospital_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).best_hospital_addr_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
    
		export Promote_last_name_stats(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).last_name_stats_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).last_name_stats_last_name_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
		
		export Promote_source_confidence_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).source_confidence_lu_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).source_confidence_lu_file_code_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;	
		
		export Promote_ignore_terms_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).ignore_terms_lu_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).ignore_terms_lu_code_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
		
		
		export Promote_taxon_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).taxon_lu_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).taxon_lu_code_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
		
		export Promote_abbr_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).abbr_lu_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).abbr_lu_code_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
		
		
	  export Promote_call_queue_bad(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).call_queue_bad_Base.dAll_filenames
																					+ keynames	(pversion,pUseProd).call_queue_bad_phone_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
		
		
		export Promote_medschool(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames =  keynames_w_medschool	(pversion,pUseProd).medschool_msid_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;

export Promote_medschool_wordlist(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames =  keynames_w_medschool	(pversion,pUseProd).medschool_wordlist_word_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
	
	
	
export Promote_non_medschool(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames =  keynames_w_medschool	(pversion,pUseProd).non_medschool_msid_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;

export Promote_non_medschool_wordlist(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames =  keynames_w_medschool	(pversion,pUseProd).non_medschool_wordlist_word_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
		
	
	
	end;