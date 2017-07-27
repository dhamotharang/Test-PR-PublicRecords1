IMPORT tools;

lay_builds     := tools.Layout_FilenameVersions.builds;
numGenerations := 2;

EXPORT Promote    := MODULE

    EXPORT Promote_organization(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).organization_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;

    EXPORT Promote_affiliations(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).affiliations_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;
					
    EXPORT Promote_aha(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).aha_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;
		
    EXPORT Promote_dea(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).dea_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;

    EXPORT Promote_npi(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).npi_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;

    EXPORT Promote_pos(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).pos_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;
		
    EXPORT Promote_crosswalk(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).crosswalk_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;

	
	EXPORT Promote_Org_MastKeys(
			STRING								pversion				= 	''
			,BOOLEAN							pUseProd			= 	false
			,STRING								pFilter					= 	''
			,BOOLEAN							pDelete					= 	false
			,BOOLEAN							pisTesting			= 	false
      ,UNSIGNED1            pnGenerations       = 3                           			
			,DATASET(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).crosswalk_base.dAll_filenames
		) := MODULE
				EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,pnGenerations := 2);
			
	END;
	EXPORT Promote_FacilitiesKey(
			string								pversion				= 	''
			,boolean							pUseProd			= 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			//,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).Organization_Base.dAll_filenames
			,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).Organization_Base.dAll_filenames
																								+ keynames    (pversion,pUseProd).Facilities_LNFID_key.dAll_filenames 
		) := MODULE
				EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,pnGenerations := 2);
			
	END;
	
	EXPORT promote_Affilitaions_Relationship(
			string								pversion				= 	''
			,boolean							pUseProd			= 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).Relationship_Base.dAll_filenames
		) := MODULE
				EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,pnGenerations := 2);
			
	END;
	
	
	EXPORT Promote_Key1(
			string								pversion				= 	''
			,boolean							pUseProd			= 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).Relationship_Base.dAll_filenames
																																	+ keynames    (pversion,pUseProd).Relationship_ID1_key.dAll_filenames    
																																	+ keynames  (pversion,pUseProd).Relationship_ID1Type_key.dAll_filenames
																																	+ keynames  (pversion,pUseProd).Relationship_ID1_ID1type.dAll_filenames
			
		) := MODULE
				EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,pnGenerations := 2);
			
	END;


	EXPORT Promote_Key2(
			string								pversion				= 	''
			,boolean							pUseProd			= 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).Relationship_Base.dAll_filenames
																																	+ keynames    (pversion,pUseProd).Relationship_ID2_key.dAll_filenames    
																																	+ keynames  (pversion,pUseProd).Relationship_ID2Type_key.dAll_filenames
																																	+ keynames  (pversion,pUseProd).Relationship_ID2_ID2type.dAll_filenames
			
		) := MODULE
				EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,pnGenerations := 2);
			
	END;
	
END;		
		
