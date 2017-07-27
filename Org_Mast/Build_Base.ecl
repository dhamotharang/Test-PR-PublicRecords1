//Defines full build process
IMPORT _control, versioncontrol,Org_Mast;

EXPORT Build_Base := module
/*==============================================================
|   Individual
+==============================================================*/

	EXPORT build_base_organization(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.organization_Base						) pBaseFile						= Files().organization_base.qa ) := MODULE

		EXPORT build_base_organization	:= Update_base(pversion, pUseProd).organization_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).organization_base.new
					,build_base_organization
					,Build_organization_Base
		);

		EXPORT full_build_organization	:=
			SEQUENTIAL(
				Build_organization_base
				,Promote.promote_organization(pversion, pUseProd).buildfiles.New2Built);

		EXPORT organization_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_organization
				,output('No Valid version parameter passed, skipping organization build')
		);
	END;
	

	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	EXPORT build_base_affiliations(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.affiliations_Base						) pBaseFile						= Files().affiliations_base.qa ) := MODULE

		EXPORT build_base_affiliations	:= Update_base(pversion, pUseProd).affiliations_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).affiliations_base.new
					,build_base_affiliations
					,Build_affiliations_Base
		);

		EXPORT full_build_affiliations	:=
			SEQUENTIAL(
				Build_affiliations_base
				,Promote.promote_affiliations(pversion, pUseProd).buildfiles.New2Built);

		EXPORT affiliations_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_affiliations
				,output('No Valid version parameter passed, skipping affiliations build')
		);
	END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	EXPORT build_base_aha(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.aha_Base						) pBaseFile						= Files().aha_base.qa ) := MODULE

		EXPORT build_base_aha	:= Update_base(pversion, pUseProd).aha_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).aha_base.new
					,build_base_aha
					,Build_aha_Base
		);

		EXPORT full_build_aha	:=
			SEQUENTIAL(
				Build_aha_base
				,Promote.promote_aha(pversion, pUseProd).buildfiles.New2Built);

		EXPORT aha_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_aha
				,output('No Valid version parameter passed, skipping aha build')
		);
	END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	EXPORT build_base_dea(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.dea_Base						) pBaseFile						= Files().dea_base.qa ) := MODULE

		EXPORT build_base_dea	:= Update_base(pversion, pUseProd).dea_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).dea_base.new
					,build_base_dea
					,Build_dea_Base
		);

		EXPORT full_build_dea	:=
			SEQUENTIAL(
				Build_dea_base
				,Promote.promote_dea(pversion, pUseProd).buildfiles.New2Built);

		EXPORT dea_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_dea
				,output('No Valid version parameter passed, skipping dea build')
		);
	END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	EXPORT build_base_npi(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.npi_Base						) pBaseFile						= Files().npi_base.qa ) := MODULE

		EXPORT build_base_npi	:= Update_base(pversion, pUseProd).npi_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).npi_base.new
					,build_base_npi
					,Build_npi_Base
		);

		EXPORT full_build_npi	:=
			SEQUENTIAL(
				Build_npi_base
				,Promote.promote_npi(pversion, pUseProd).buildfiles.New2Built);

		EXPORT npi_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_npi
				,output('No Valid version parameter passed, skipping npi build')
		);
	END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	EXPORT build_base_pos(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.pos_Base						) pBaseFile						= Files().pos_base.qa ) := MODULE

		EXPORT build_base_pos	:= Update_base(pversion, pUseProd).pos_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).pos_base.new
					,build_base_pos
					,Build_pos_Base
		);

		EXPORT full_build_pos	:=
			SEQUENTIAL(
				Build_pos_base
				,Promote.promote_pos(pversion, pUseProd).buildfiles.New2Built);

		EXPORT pos_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_pos
				,output('No Valid version parameter passed, skipping pos build')
		);
	END;

	EXPORT build_base_crosswalk(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.crosswalk_Base						) pBaseFile						= Files().crosswalk_base.qa ) := MODULE

		EXPORT build_base_crosswalk	:= Update_base(pversion, pUseProd).crosswalk_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).crosswalk_base.new
					,build_base_crosswalk
					,Build_crosswalk_Base
		);

		EXPORT full_build_crosswalk	:=
			SEQUENTIAL(
				Build_crosswalk_base
				,Promote.promote_crosswalk(pversion, pUseProd).buildfiles.New2Built);

		EXPORT crosswalk_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_crosswalk
				,output('No Valid version parameter passed, skipping crosswalk build')
		);
	END;
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

/* 	EXPORT build_base_Affiliate_Relationship(
   			STRING			pversion
   			,BOOLEAN		pUseProd		= false
   			,DATASET(Layouts.Relationship_Base						) pBaseFile						= Files().Relationship_base.qa ) := MODULE	
   
   					
   		EXPORT Build_base_Affiliate_Relationship	:= Update_base(pversion, pUseProd).Relationship_base;
   		VersionControl.macBuildNewLogicalFile(
   					Filenames(pversion,pUseProd).Relationship_base.new
   					,build_base_Affiliate_Relationship
   					,Build_Affiliate_Relationship
   		);
   		
   		EXPORT full_build_Affiliate_Relationship	:=
   			SEQUENTIAL(
   				Build_Affiliate_Relationship
   				,Promote.promote_Affilitaions_Relationship(pversion, pUseProd).buildfiles.New2Built);
   			
   	
   		EXPORT Affiliate_Relationship_all	:=	 if(VersionControl.IsValidVersion(pversion)
   				,full_build_Affiliate_Relationship
   				,output('No Valid version parameter passed, skipping Affilitaions_Relationship build')
   				);
   
   	END;// Module
*/
	
END;
