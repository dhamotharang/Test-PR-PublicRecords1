import _control, versioncontrol, MPRD, BIPV2_Company_Names;

export Build_Base:=module
	
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
				
	export build_base_taxonomy_full_lu(
		 string			pversion
		,boolean		pUseProd		= false
		,dataset(MPRD.Layouts.taxonomy_full_lu_Base) pBaseFile		= MPRD.Files().taxonomy_full_lu_base.qa) := module
				
		export build_base_taxonomy_full_lu	:= MPRD.Update_base(pversion, pUseProd).taxonomy_full_lu_base;
		VersionControl.macBuildNewLogicalFile(
  																	 MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_base.new
																		,build_base_taxonomy_full_lu
																		,Build_taxonomy_full_lu_base);
	
		export full_build_taxonomy_full_lu	:=
			sequential(
				 Build_taxonomy_full_lu_base
				,MPRD.Promote.promote_taxonomy_full_lu(pversion, pUseProd).buildfiles.New2Built);
	
		export taxonomy_full_lu_all	:=
			 if(VersionControl.IsValidVersion(pversion)
						,full_build_taxonomy_full_lu
						,output('No Valid version parameter passed, skipping taxonomy_full_lu build'));
	end;	
end;