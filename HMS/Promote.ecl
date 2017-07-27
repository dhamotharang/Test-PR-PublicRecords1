IMPORT tools, HMS;

lay_builds     := tools.Layout_FilenameVersions.builds;
numGenerations := 2;

EXPORT Promote    := MODULE

    EXPORT Promote_individual(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    
    END;
			
    EXPORT Promote_individual_addresses(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_addresses_base.dAll_filenames
                                                                                    //+ keynames    (pversion,pUseProd).individual_group_key.dAll_filenames    // individual keys - group_key, lnpid
                                                                                    //+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    
    END;
				
    EXPORT Promote_individual_state_licenses(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_state_licenses_base.dAll_filenames
                                                                                    //+ keynames    (pversion,pUseProd).individual_group_key.dAll_filenames    // individual keys - group_key, lnpid
                                                                                    //+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    
    END;
				
    EXPORT Promote_individual_dea(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_dea_base.dAll_filenames
                                                                                    //+ keynames    (pversion,pUseProd).individual_group_key.dAll_filenames    // individual keys - group_key, lnpid
                                                                                    //+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    
    END;
				
    EXPORT Promote_individual_state_csr(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_state_csr_base.dAll_filenames
                                                                                    //+ keynames    (pversion,pUseProd).individual_group_key.dAll_filenames    // individual keys - group_key, lnpid
                                                                                    //+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    
    END;
				
    EXPORT Promote_individual_sanctions(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_sanctions_base.dAll_filenames
                                                                                    //+ keynames    (pversion,pUseProd).individual_group_key.dAll_filenames    // individual keys - group_key, lnpid
                                                                                    //+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    
    END;
				
    EXPORT Promote_individual_gsa_sanctions(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_gsa_sanctions_base.dAll_filenames
                                                                                    //+ keynames    (pversion,pUseProd).individual_group_key.dAll_filenames    // individual keys - group_key, lnpid
                                                                                    //+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    
    END;
				
    EXPORT Promote_state_license_types(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).state_license_types_base.dAll_filenames
                                                                                    //+ keynames    (pversion,pUseProd).individual_group_key.dAll_filenames    // individual keys - group_key, lnpid
                                                                                    //+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    
    END;

    EXPORT Promote_individual_address_faxes(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_address_faxes_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;

    EXPORT Promote_individual_address_phones(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_address_phones_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;

    EXPORT Promote_individual_certifications(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_certifications_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;

    EXPORT Promote_individual_covered_recipients(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_covered_recipients_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;

    EXPORT Promote_individual_education(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_education_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;

    EXPORT Promote_individual_languages(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_languages_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;

    EXPORT Promote_individual_specialty(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_specialty_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;
		
    EXPORT Promote_piid_migration(
        STRING                              pversion            = ''
        ,BOOLEAN                            pUseProd            = false
        ,STRING                             pFilter             = ''
        ,BOOLEAN                            pDelete             = false
        ,BOOLEAN                            pisTesting          = false
        ,UNSIGNED1                          pnGenerations       = 3                           
        ,DATASET(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).piid_migration_base.dAll_filenames
        ) :=    MODULE
            EXPORT buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := numGenerations);
    END;
		
	EXPORT Promote_Providerkeys(
			string								pversion				= 	''
			,boolean							pUseProd			= 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,dataset(lay_builds)	pBuildFilenames = 	HMS.Filenames(pversion,pUseProd).Individual_Base.dAll_filenames
																								+ keynames(pversion,pUseProd).Provider_PIID_key.dAll_filenames 

		) := MODULE
				EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,pnGenerations := 2);
			
	END;
		
		
END;