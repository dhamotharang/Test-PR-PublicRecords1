import tools;

lay_builds     := tools.Layout_FilenameVersions.builds;

export Promote    := module

export Promote_vendorsrc2(
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames =     Filenames(pversion,pUseProd).Base.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
    
    
end;
