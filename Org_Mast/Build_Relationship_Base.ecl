IMPORT _control, versioncontrol,Org_Mast;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	EXPORT Build_Relationship_Base(
			STRING			Afflversion
			,STRING			Org_Mst_Version
			,STRING			pversion
			,BOOLEAN		pUseProd		= false
			,DATASET(Layouts.Relationship_Base						) pBaseFile						= Files().Relationship_base.qa ) := MODULE	

					
		EXPORT Build_base_Relationship	:= Update_Relationship_base(pversion ,Afflversion, Org_Mst_Version, pUseProd).Relationship_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Relationship_base.new
					,build_base_Relationship
					,Build_Relationship
		);
		
		EXPORT full_build_Relationship	:=
			SEQUENTIAL(
				Build_Relationship
				,Promote.promote_Affilitaions_Relationship(pversion, pUseProd).buildfiles.New2Built);
			
	
		EXPORT Relationship_all	:=	 if(VersionControl.IsValidVersion(pversion)
				,full_build_Relationship
				,output('No Valid version parameter passed, skipping Affilitaions_Relationship build')
				);

	END;// Module
