IMPORT doxie, VersionControl, AutoKeyB2, RoxieKeyBuild, ut, standard;

EXPORT Build_Keys
			:= MODULE

	EXPORT Build_Keys_Facilities(string pversion, boolean pUseProd = false) := module
				//VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Facilities_LNFID_key.New		,BuildFacilities_LNFIDLnKey	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Facilities_LNFID.New		,BuildFacilities_LNFIDLnKey	);
				
				SHARED full_build :=
					sequential(
						BuildFacilities_LNFIDLnKey,
						Promote.Promote_FacilitiesKey(pversion,pUseProd).buildfiles.New2Built
					);
		
				EXPORT FacilitiesKey :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping State License atribute')
					);
		
	END;
	
	EXPORT Build_Keys_Relationship_Key1(string pversion, boolean pUseProd = false) := module
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Relationship_ID1.New		,BuildRelationship_ID1_key	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Relationship_ID1Type_key.New		,BuildRelationship_ID1Type_key	);
				//VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Key1.New		,BuildRelationship_Key1	);
				
				
				SHARED full_build :=
					sequential(
						BuildRelationship_ID1_key,
						BuildRelationship_ID1Type_key,
						//BuildRelationship_Key1,
						Promote.Promote_Key1(pversion,pUseProd).buildfiles.New2Built
					);
		
				EXPORT Relationship_Key1 :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping State License atribute')
					);
	END;
					
	EXPORT Build_Keys_Relationship_Key2(string pversion, boolean pUseProd = false) := module
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Relationship_ID2.New		,BuildRelationship_ID2_key	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Relationship_ID2Type_key.New		,BuildRelationship_ID2Type_key	);
				//VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Key2.New		,BuildRelationship_ID2_ID2type	);
				
				
				
				SHARED full_build :=
					sequential(
						BuildRelationship_ID2_key,
						BuildRelationship_ID2Type_key,
						//BuildRelationship_ID2_ID2type,
						Promote.Promote_Key2(pversion,pUseProd).buildfiles.New2Built
					);
		
				EXPORT Relationship_Key2 :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping State License atribute')
					);

	END;
	

END;