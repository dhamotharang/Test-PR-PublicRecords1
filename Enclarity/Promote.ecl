import tools;
lay_builds     := tools.Layout_FilenameVersions.builds;
export Promote    := module

    export Promote_collapse(
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).collapse_base.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    
    export Promote_split(
        string                              pversion            = ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
       ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).split_base.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    
    export Promote_drop(
        string                              pversion            = ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
       ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).drop_base.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;

    export Promote_facility(
        string                              pversion            = ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).facility_base.dAll_filenames
                                                                                    + keynames    (pversion,pUseProd).facility_group_key.dAll_filenames    // facility keys - group_key and addr_key
                                                                                    // + keynames  (pversion,pUseProd).facility_addr_key.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;

    export Promote_individual(
        string                              pversion            = ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).individual_base.dAll_filenames
                                                                                    + keynames    (pversion,pUseProd).individual_group_key.dAll_filenames    // individual keys - group_key, lnpid
                                                                                    + keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    
    export Promote_associate (
        string                              pversion            = ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).associate_base.dAll_filenames
                                                                                    + keynames    (pversion,pUseProd).associate_group_key.dAll_filenames    // associate keys - group_key, addr_key
                                                                                    // + keynames  (pversion,pUseProd).associate_addr_key.dAll_filenames
                                                                                    + keynames  (pversion,pUseProd).associate_bill_tin.dAll_filenames
                                                                                    + keynames  (pversion,pUseProd).associate_bgk.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    
    export Promote_address (
        string                              pversion            = ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).address_base.dAll_filenames
                                                                                    // + keynames    (pversion,pUseProd).address_group_key.dAll_filenames    // address keys - group_key, addr_key
                                                                                    // + keynames  (pversion,pUseProd).address_addr_key.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    
    export Promote_DEA (
        string                              pversion            = ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).DEA_base.dAll_filenames
                                                                                    // + keynames    (pversion,pUseProd).dea_group_key.dAll_filenames    // dea keys - group_key, dea_num
                                                                                    // + keynames  (pversion,pUseProd).dea_dea_num.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;

    export Promote_license (
        string                              pversion            = ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).license_base.dAll_filenames
                                                                                    + keynames    (pversion,pUseProd).license_group_key.dAll_filenames    // license keys - group_key, lic_num
                                                                                    // + keynames  (pversion,pUseProd).license_lic_num.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    
    export Promote_taxonomy (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).taxonomy_base.dAll_filenames
                                                                                    + keynames    (pversion,pUseProd).taxonomy_group_key.dAll_filenames    // taxonomy keys - group_key, taxonomy
                                                                                    // + keynames  (pversion,pUseProd).taxonomy_taxonomy.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;

    export Promote_NPI (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).npi_base.dAll_filenames
                                                                                    // + keynames    (pversion,pUseProd).npi_group_key.dAll_filenames    // npi keys - group_key, npi_num
                                                                                    // + keynames  (pversion,pUseProd).npi_npi_num.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;

    export Promote_medschool (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).medschool_base.dAll_filenames
                                                                                    + keynames    (pversion,pUseProd).medschool_group_key.dAll_filenames    // medschool keys - group_key
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    
    export Promote_tax_codes (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).tax_codes_base.dAll_filenames
                                                                                    // + keynames    (pversion,pUseProd).tax_codes_taxonomy.dAll_filenames    // tax_codes keys - taxonomy
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    export Promote_prov_ssn (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).prov_ssn_base.dAll_filenames
                                                                                    // + keynames    (pversion,pUseProd).prov_ssn_group_key.dAll_filenames    // prov_ssn keys - group_key, ssn
                                                                                    // + keynames  (pversion,puseProd).prov_ssn_ssn.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;

    export Promote_specialty (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).specialty_base.dAll_filenames
                                                                                    + keynames    (pversion,pUseProd).specialty_group_key_spec_code.dAll_filenames    //specialty keys - group_key+spec_code, spec_desc+group_key
                                                                                    // + keynames  (pversion,pUseProd).specialty_spec_desc_group_key.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;

    export Promote_sanc_prov_type (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).sanc_prov_type_base.dAll_filenames
                                                                                    + keynames    (pversion,pUseProd).sanc_prov_type_sanc_prov_type_code.dAll_filenames    // sanc_prov_type keys - sanc_prov_type_code
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;

    export Promote_sanc_codes (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).sanc_codes_base.dAll_filenames
                                                                                    + keynames    (pversion,pUseProd).sanc_codes_sanc_codes.dAll_filenames    // sanc_codes keys - sanc_code
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;

    // export Promote_dea_BAcodes (
        // string                           pversion            =  ''
        // ,boolean                         pUseProd            = false
        // ,string                          pFilter             = ''
        // ,boolean                         pDelete             = false
        // ,boolean                         pisTesting          = false
        // ,unsigned1                          pnGenerations       = 3                           
        // ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).dea_BAcodes_base.dAll_filenames
                                                                                    // + keynames    (pversion,pUseProd).dea_bacodes_dea_bus_act_ind.dAll_filenames    //dea_bacodes keys - dea_bus_act_ind+dea_bus_act_ind_sub
        // ) :=    module
            // export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    // end;

    export Promote_prov_birthdate (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).prov_birthdate_base.dAll_filenames
                                                                                    // + keynames    (pversion,pUseProd).prov_birthdate_group_key.dAll_filenames    // prov_birthdate keys - group_key
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;

    export Promote_sanction (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).sanction_base.dAll_filenames
                                                                                    + keynames    (pversion,pUseProd).sanction_group_key.dAll_filenames    // sanction keys - group_key
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    
end;
