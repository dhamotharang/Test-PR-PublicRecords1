//Defines full build process
import _control, versioncontrol, MPRD;

export Build_Base:=module
	export build_base_facility(
		 string				pversion
		,boolean			pUseProd		= false
		,dataset(MPRD.Layouts.Facility_Base)pBaseFile		= MPRD.Files().Facility_base.qa) := module
	
		shared build_base_facility := MPRD.Update_Base(pversion,pUseProd).facility_base;
		VersionControl.macBuildNewLogicalFile(
																		 MPRD.Filenames(pversion, pUseProd).Facility_base.new
																	 	,build_base_facility
																		,Build_Facility_Base);
		shared full_build_facility	:=  
			sequential(				
			 		 Build_Facility_Base
					,MPRD.Promote.promote_facility(pversion, pUseProd).buildfiles.New2Built);
	
		export facility_all	:=
			if(VersionControl.IsValidVersion(pversion)
					,full_build_facility
					,output('No Valid version parameter passed, skipping facility build'));
	end;
	
	export build_base_individual(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.Individual_Base) pBaseFile		= MPRD.Files().Individual_base.qa) := module
				
		export build_base_individual	:= MPRD.Update_base(pversion, pUseProd).Individual_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).Individual_base.new
																		,build_base_individual
																		,Build_Individual_Base);
	
		export full_build_individual	:=
			sequential(
				 Build_individual_base
				,MPRD.Promote.promote_individual(pversion, pUseProd).buildfiles.New2Built);
	
		export individual_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;
		
	export build_base_basc_cp(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.choice_point_Base) pBaseFile		= MPRD.Files().basc_cp_base.qa) := module
				
		export build_base_basc_cp	:= MPRD.Update_base(pversion, pUseProd).choice_point_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).basc_cp_base.new
																		,build_base_basc_cp
																		,Build_basc_cp_Base);
	
		export full_build_individual	:=
			sequential(
				 Build_basc_cp_Base
				,MPRD.Promote.promote_basc_cp(pversion, pUseProd).buildfiles.New2Built);
	
		export basc_cp_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping basc_cp build'));
	end;			
	
	export build_base_basc_claims(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.basc_claims_Base) pBaseFile			= MPRD.Files().basc_claims_base.qa) := module
				
		export build_base_basc_claims	:= MPRD.Update_base(pversion, pUseProd).basc_claim_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).basc_claims_base.new
																		,build_base_basc_claims
																		,Build_basc_claims_Base);
	
		export full_build_individual	:=
			sequential(
				 Build_basc_claims_Base
				,MPRD.Promote.promote_basc_claims(pversion, pUseProd).buildfiles.New2Built);
	
		export basc_claims_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping basc_claims build'));
	end;	

	export build_base_claims_by_month(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.claims_by_month_Base) pBaseFile		= MPRD.Files().claims_by_month_base.qa) := module
				
		export build_base_claims_by_month	:= MPRD.Update_base(pversion, pUseProd).claims_by_month_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).claims_by_month_base.new
																		,build_base_claims_by_month
																		,Build_claims_by_month_Base);
	
		export full_build_individual	:=
			sequential(
				 Build_claims_by_month_Base
				,MPRD.Promote.promote_claims_by_month(pversion, pUseProd).buildfiles.New2Built);
	
		export claims_by_month_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping claims_by_month build'));
	end;		
		
	export build_base_claims_addr_master(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.claims_address_master_Base) pBaseFile		= MPRD.Files().claims_addr_master_base.qa) := module
				
		export build_base_claims_addr_master	:= MPRD.Update_base(pversion, pUseProd).claims_address_master_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).claims_addr_master_base.new
																		,build_base_claims_addr_master
																		,Build_claims_addr_master_Base);
	
		export full_build_individual	:=
			sequential(
				 Build_claims_addr_master_Base
				,MPRD.Promote.promote_claims_addr_master(pversion, pUseProd).buildfiles.New2Built);
	
		export claims_addr_master_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping claims_addr_master build'));
	end;		
		
	export build_base_npi_tin_xref(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.npi_tin_xref_Base) pBaseFile		= MPRD.Files().npi_tin_xref_base.qa) := module
				
		export build_base_npi_tin_xref	:= MPRD.Update_base(pversion, pUseProd).npi_tin_xref_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).npi_tin_xref_base.new
																		,build_base_npi_tin_xref
																		,Build_npi_tin_xref_Base);
	
		export full_build_individual	:=
			sequential(
				 Build_npi_tin_xref_Base
				,MPRD.Promote.promote_npi_tin_xref(pversion, pUseProd).buildfiles.New2Built);
	
		export npi_tin_xref_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;		
		
	export build_base_npi_extension(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.npi_extension_Base) pBaseFile		= MPRD.Files().npi_extension_base.qa) := module
				
		export build_base_npi_extension	:= MPRD.Update_base(pversion, pUseProd).npi_extension_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).npi_extension_base.new
																		,build_base_npi_extension
																		,Build_npi_extension_base);
	
		export full_build_individual	:=
			sequential(
				 Build_npi_extension_base
				,MPRD.Promote.promote_npi_extension(pversion, pUseProd).buildfiles.New2Built);
	
		export npi_extension_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;		
	
	export build_base_npi_extension_facility(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.npi_extension_facility_Base) pBaseFile		= MPRD.Files().npi_extension_base.qa) := module
				
		export build_base_npi_extension_facility	:= MPRD.Update_base(pversion, pUseProd).npi_extension_facility_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).npi_extension_facility_base.new
																		,build_base_npi_extension_facility
																		,Build_npi_extension_facility_base);
	
		export full_build_individual	:=
			sequential(
				 Build_npi_extension_facility_base
				,MPRD.Promote.promote_npi_extension_facility(pversion, pUseProd).buildfiles.New2Built);
	
		export npi_extension_facility_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
		
	export build_base_taxonomy_equiv(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.taxonomy_equiv_Base) pBaseFile		= MPRD.Files().taxonomy_equiv_base.qa) := module
				
		export build_base_taxonomy_equiv	:= MPRD.Update_base(pversion, pUseProd).taxonomy_equiv_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).taxonomy_equiv_base.new
																		,build_base_taxonomy_equiv
																		,Build_taxonomy_equiv_base);
	
		export full_build_individual	:=
			sequential(
				 Build_taxonomy_equiv_base
				,MPRD.Promote.promote_taxonomy_equiv(pversion, pUseProd).buildfiles.New2Built);
	
		export taxonomy_equiv_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
	
	export build_base_basc_deceased(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.basc_deceased_Base) pBaseFile			= MPRD.Files().basc_deceased_base.qa) := module
				
		export build_base_basc_deceased	:= MPRD.Update_base(pversion, pUseProd).basc_deceased_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).basc_deceased_base.new
																		,build_base_basc_deceased
																		,Build_basc_deceased_base);
	
		export full_build_individual	:=
			sequential(
				 Build_basc_deceased_base
				,MPRD.Promote.promote_basc_deceased(pversion, pUseProd).buildfiles.New2Built);
	
		export basc_deceased_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	

	export build_base_basc_addr(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.basc_addr_Base) pBaseFile		= MPRD.Files().basc_addr_base.qa) := module
				
		export build_base_basc_addr	:= MPRD.Update_base(pversion, pUseProd).basc_addr_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).basc_addr_base.new
																		,build_base_basc_addr
																		,Build_basc_addr_base);
	
		export full_build_individual	:=
			sequential(
				 Build_basc_addr_base
				,MPRD.Promote.promote_basc_addr(pversion, pUseProd).buildfiles.New2Built);
	
		export basc_addr_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
	
	export build_base_client_data(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.client_data_Base) pBaseFile		= MPRD.Files().client_data_base.qa) := module
				
		export build_base_client_data	:= MPRD.Update_base(pversion, pUseProd).client_data_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).client_data_base.new
																		,build_base_client_data
																		,Build_client_data_base);
	
		export full_build_individual	:=
			sequential(
				 Build_client_data_base
				,MPRD.Promote.promote_client_data(pversion, pUseProd).buildfiles.New2Built);
	
		export client_data_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
		
	export build_base_office_attributes(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.office_attributes_Base) pBaseFile			= MPRD.Files().office_attributes_base.qa) := module
				
		export build_base_office_attributes	:= MPRD.Update_base(pversion, pUseProd).office_attributes_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).office_attributes_base.new
																		,build_base_office_attributes
																		,Build_office_attributes_base);
	
		export full_build_individual	:=
			sequential(
				 Build_office_attributes_base
				,MPRD.Promote.promote_office_attributes(pversion, pUseProd).buildfiles.New2Built);
	
		export office_attributes_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
		
	export build_base_office_attributes_facility(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.office_attributes_facility_Base) pBaseFile		= MPRD.Files().office_attributes_facility_base.qa) := module
				
		export build_base_office_attributes_facility	:= MPRD.Update_base(pversion, pUseProd).office_attributes_facility_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).office_attributes_facility_base.new
																		,build_base_office_attributes_facility
																		,Build_office_attributes_facility_base);
	
		export full_build_individual	:=
			sequential(
				 Build_office_attributes_facility_base
				,MPRD.Promote.promote_office_attributes_facility(pversion, pUseProd).buildfiles.New2Built);
	
		export office_attributes_facility_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
		
	export build_base_std_terms_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.std_terms_lu_Base) pBaseFile		= MPRD.Files().std_terms_lu_base.qa) := module
				
		export build_base_std_terms_lu	:= MPRD.Update_base(pversion, pUseProd).std_terms_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).std_terms_lu_base.new
																		,build_base_std_terms_lu
																		,Build_std_terms_lu_base);
	
		export full_build_individual	:=
			sequential(
				 Build_std_terms_lu_base
				,MPRD.Promote.promote_std_terms_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export std_terms_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
		
	export build_base_taxonomy_full_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.taxonomy_full_lu_Base) pBaseFile		= MPRD.Files().taxonomy_full_lu_base.qa) := module
				
		export build_base_taxonomy_full_lu	:= MPRD.Update_base(pversion, pUseProd).taxonomy_full_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_base.new
																		,build_base_taxonomy_full_lu
																		,Build_taxonomy_full_lu_base);
	
		export full_build_individual	:=
			sequential(
				 Build_taxonomy_full_lu_base
				,MPRD.Promote.promote_taxonomy_full_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export taxonomy_full_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
		
	export build_base_dir_confidence_2010_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.dirconfidence2010lu_base) pBaseFile		= MPRD.Files().dir_confidence_2010_lu_base.qa) := module
				
		export build_base_dir_confidence_2010_lu	:= MPRD.Update_base(pversion, pUseProd).dir_confidence_2010_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).dir_confidence_2010_lu_base.new
																		,build_base_dir_confidence_2010_lu
																		,Build_dir_confidence_2010_lu_base);
	
		export full_build_individual	:=
			sequential(
				 Build_dir_confidence_2010_lu_base
				,MPRD.Promote.Promote_dir_confidence_2010_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export dir_confidence_2010_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
		
  export build_base_specialty_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.specialty_lu_base) pBaseFile		= MPRD.Files().specialty_lu_base.qa) := module
				
		export build_base_specialty_lu	:= MPRD.Update_base(pversion, pUseProd).specialty_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).specialty_lu_base.new
																		,build_base_specialty_lu
																		,Build_specialty_lu_base);
	
		export full_build_individual	:=
			sequential(
				 Build_specialty_lu_base
				,MPRD.Promote.Promote_specialty_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export specialty_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;			
		
	export build_base_group_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.group_lu_base) pBaseFile		= MPRD.Files().group_lu_base.qa) := module
				
		export build_base_group_lu	:= MPRD.Update_base(pversion, pUseProd).group_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).group_lu_base.new
																		,build_base_group_lu
																		,Build_group_lu_base);
	
		export full_build_individual	:=
			sequential(
				 Build_group_lu_base
				,MPRD.Promote.Promote_group_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export group_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
		
 	export build_base_hospital_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.hospital_lu_base) pBaseFile		= MPRD.Files().hospital_lu_base.qa) := module
				
		export build_base_hospital_lu	:= MPRD.Update_base(pversion, pUseProd).hospital_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).hospital_lu_base.new
																		,build_base_hospital_lu
																		,Build_hospital_lu_base);
	
		export full_build_individual	:=
			sequential(
				 Build_hospital_lu_base
				,MPRD.Promote.Promote_hospital_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export hospital_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
		
  export build_base_dea_xref(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.dea_xref_base) pBaseFile		= MPRD.Files().dea_xref_base.qa) := module
				
		export build_base_dea_xref	:= MPRD.Update_base(pversion, pUseProd).dea_xref_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).dea_xref_base.new
																		,build_base_dea_xref
																		,Build_dea_xref_base);
	
		export full_build_individual	:=
			sequential(
				 Build_dea_xref_base
				,MPRD.Promote.Promote_dea_xref(pversion, pUseProd).buildfiles.New2Built);
	
		export dea_xref_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;			
		
  export build_base_lic_xref(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.lic_xref_base) pBaseFile		= MPRD.Files().lic_xref_base.qa) := module
				
		export build_base_lic_xref	:= MPRD.Update_base(pversion, pUseProd).lic_xref_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).lic_xref_base.new
																		,build_base_lic_xref
																		,Build_lic_xref_base);
	
		export full_build_individual	:=
			sequential(
				 Build_lic_xref_base
				,MPRD.Promote.Promote_lic_xref(pversion, pUseProd).buildfiles.New2Built);
	
		export lic_xref_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;			
		
	export build_base_facility_name_xref(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.facility_name_xref_base) pBaseFile		= MPRD.Files().facility_name_xref_base.qa) := module
				
		export build_base_facility_name_xref	:= MPRD.Update_base(pversion, pUseProd).facility_name_xref_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).facility_name_xref_base.new
																		,build_base_facility_name_xref
																		,Build_facility_name_xref_base);
	
		export full_build_individual	:=
			sequential(
				 Build_facility_name_xref_base
				,MPRD.Promote.Promote_facility_name_xref(pversion, pUseProd).buildfiles.New2Built);
	
		export facility_name_xref_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
		
	export build_base_addr_name_xref(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.address_name_xref_base) pBaseFile		= MPRD.Files().addr_name_xref_base.qa) := module
				
		export build_base_addr_name_xref	:= MPRD.Update_base(pversion, pUseProd).addr_name_xref_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).addr_name_xref_base.new
																		,build_base_addr_name_xref
																		,Build_addr_name_xref_base);
	
		export full_build_individual	:=
			sequential(
				 Build_addr_name_xref_base
				,MPRD.Promote.Promote_addr_name_xref(pversion, pUseProd).buildfiles.New2Built);
	
		export addr_name_xref_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
	
	export build_base_basc_facility_mme(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.basc_facility_mme_base) pBaseFile		= MPRD.Files().basc_facility_mme_base.qa) := module
				
		export build_base_basc_facility_mme	:=MPRD. Update_base(pversion, pUseProd).basc_facility_mme_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).basc_facility_mme_base.new
																		,build_base_basc_facility_mme
																		,Build_basc_facility_mme_base);
	
		export full_build_individual	:=
			sequential(
				 Build_basc_facility_mme_base
				,MPRD.Promote.Promote_basc_facility_mme(pversion, pUseProd).buildfiles.New2Built);
	
		export basc_facility_mme_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	

	export build_base_lic_filedate(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.lic_filedate_base) pBaseFile		= MPRD.Files().lic_filedate_base.qa) := module
				
		export build_base_lic_filedate	:= MPRD.Update_base(pversion, pUseProd).lic_filedate_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).lic_filedate_base.new
																		,build_base_lic_filedate
																		,Build_lic_filedate_base);
	
		export full_build_individual	:=
			sequential(
				 Build_lic_filedate_base
				,MPRD.Promote.Promote_lic_filedate(pversion, pUseProd).buildfiles.New2Built);
	
		export lic_filedate_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;		

	export build_base_nanpa(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.nanpa_base) pBaseFile		= MPRD.Files().nanpa_base.qa) := module
				
		export build_base_nanpa	:= MPRD.Update_base(pversion, pUseProd).nanpa_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).nanpa_base.new
																		,build_base_nanpa
																		,Build_nanpa_base);
	
		export full_build_individual	:=
			sequential(
				 Build_nanpa_base
				,MPRD.Promote.Promote_nanpa(pversion, pUseProd).buildfiles.New2Built);
	
		export nanpa_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;		
		
	export build_base_best_hospital(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.best_hospital_base) pBaseFile		= MPRD.Files().best_hospital_base.qa) := module
				
		export build_base_best_hospital	:= MPRD.Update_base(pversion, pUseProd).best_hospital_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).best_hospital_base.new
																		,build_base_best_hospital
																		,Build_best_hospital_base);
	
		export full_build_individual	:=
			sequential(
				 Build_best_hospital_base
				,MPRD.Promote.Promote_best_hospital(pversion, pUseProd).buildfiles.New2Built);
	
		export best_hospital_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;	
	
	export build_base_last_name_stats(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.last_name_stats_base) pBaseFile		= MPRD.Files().last_name_stats_base.qa) := module
				
		export build_base_last_name_stats	:= MPRD.Update_base(pversion, pUseProd).last_name_stats_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).last_name_stats_base.new
																		,build_base_last_name_stats
																		,Build_last_name_stats_base);
	
		export full_build_individual	:=
			sequential(
				 Build_last_name_stats_base
				,MPRD.Promote.Promote_last_name_stats(pversion, pUseProd).buildfiles.New2Built);
	
		export last_name_stats_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;		
		
	export build_base_source_confidence_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.source_confidence_lu_base) pBaseFile	= MPRD.Files().source_confidence_lu_base.qa) := module
				
		export build_base_source_confidence_lu	:= MPRD.Update_base(pversion, pUseProd).source_confidence_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).source_confidence_lu_base.new
																		,build_base_source_confidence_lu
																		,Build_source_confidence_lu_base);
	
		export full_build_individual	:=
			sequential(
				 Build_source_confidence_lu_base
				,MPRD.Promote.Promote_source_confidence_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export source_confidence_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;
		
	export build_base_ignore_terms_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.ignore_terms_lu_base) pBaseFile			= MPRD.Files().ignore_terms_lu_base.qa) := module
				
		export build_base_ignore_terms_lu	:= MPRD.Update_base(pversion, pUseProd).ignore_terms_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).ignore_terms_lu_base.new
																		,build_base_ignore_terms_lu
																		,Build_ignore_terms_lu_base);
	
		export full_build_individual	:=
			sequential(
				 Build_ignore_terms_lu_base
				,MPRD.Promote.Promote_ignore_terms_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export ignore_terms_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;
	
	export build_base_taxon_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.taxon_lu_base) pBaseFile		= MPRD.Files().taxon_lu_base.qa) := module
				
		export build_base_taxon_lu	:= MPRD.Update_base(pversion, pUseProd).taxon_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).taxon_lu_base.new
																		,build_base_taxon_lu
																		,Build_taxon_lu_base);
	
		export full_build_individual	:=
			sequential(
				 Build_taxon_lu_base
				,MPRD.Promote.Promote_taxon_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export taxon_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping taxon lu build'));
	end;
		
	export build_base_abbr_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.abbr_lu_base) pBaseFile		= MPRD.Files().abbr_lu_base.qa) := module
				
		export build_base_abbr_lu	:= MPRD.Update_base(pversion, pUseProd).abbr_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).abbr_lu_base.new
																		,build_base_abbr_lu
																		,Build_abbr_lu_base);
	
		export full_build_individual	:=
			sequential(
				 Build_abbr_lu_base
				,MPRD.Promote.Promote_abbr_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export abbr_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping abbr_lu build'));
	end;
	
	export build_base_call_queue_bad(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.call_queue_bad_base) pBaseFile		= MPRD.Files().call_queue_bad_base.qa) := module
				
		export build_base_call_queue_bad	:= MPRD.Update_base(pversion, pUseProd).call_queue_bad_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).call_queue_bad_base.new
																		,build_base_call_queue_bad
																		,Build_call_queue_bad_base);
	
		export full_build_individual	:=
			sequential(
				 Build_call_queue_bad_base
				,MPRD.Promote.Promote_call_queue_bad(pversion, pUseProd).buildfiles.New2Built);
	
		export call_queue_bad_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_individual
						,output('No Valid version parameter passed, skipping individual build'));
	end;
end;