import tools;
lay_builds     := tools.Layout_FilenameVersions.builds;
export Promote    := module

    export Promote_facility_sanctions (
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 2                           
        ,dataset(lay_builds)    pBuildFilenames = Enclarity_Facility_Sanctions.Filenames(pversion,pUseProd).facility_sanctions_base.dAll_filenames
                                                + Enclarity_facility_Sanctions.Keynames (pversion,pUseProd).facility_sanctions_lnfid.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    
end;
