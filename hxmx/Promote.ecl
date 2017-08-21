IMPORT tools, hxmx;
lay_builds     := tools.Layout_FilenameVersions.builds;

EXPORT Promote    := MODULE

    EXPORT Promote_hx(
        STRING                              pVersion            =  ''
        ,BOOLEAN                            pUseProd            = FALSE
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = FALSE
        ,BOOLEAN                            pisTesting          = FALSE
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     hxmx.Filenames(pVersion,pUseProd).hx_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := TRUE,pisTesting := FALSE, pnGenerations := 2);

    END;

		EXPORT Promote_mx(
        STRING                              pVersion            =  ''
        ,BOOLEAN                            pUseProd            = FALSE
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = FALSE
        ,BOOLEAN                            pisTesting          = FALSE
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     hxmx.Filenames(pVersion,pUseProd).mx_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := TRUE,pisTesting := FALSE, pnGenerations := 2);

    END;

END;