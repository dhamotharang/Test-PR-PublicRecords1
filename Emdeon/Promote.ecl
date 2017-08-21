IMPORT tools, Emdeon;

lay_builds     := tools.Layout_FilenameVersions.builds;

EXPORT Promote    := MODULE

    EXPORT Promote_claims(
        STRING                              pVersion            =  ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Emdeon.Filenames(pVersion,pUseProd).claims_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    END;
		
		EXPORT Promote_splits(
        STRING                              pVersion            =  ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Emdeon.Filenames(pVersion,pUseProd).splits_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    END;
    
		EXPORT Promote_detail(
        STRING                              pVersion            =  ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Emdeon.Filenames(pVersion,pUseProd).detail_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    END;

END;
