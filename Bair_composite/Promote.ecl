import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote    := module
		
		export Promote_Mo_Phone(
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
				,boolean														pUseDelta						= false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames = //Filenames(pversion,pUseProd, pUseDelta).dbo_mo_Base.dAll_filenames	+ 
																									keynames(pversion,pUseProd, pUseDelta).mo_phone_key.dAll_filenames
        ) :=    module
								export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
		export Promote_Mo_v2_Phone(
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
				,boolean														pUseDelta						= false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames = //Filenames(pversion,pUseProd, pUseDelta).dbo_mo_Base.dAll_filenames	+ 
																									keynames(pversion,pUseProd, pUseDelta).mo_phone_v2_key.dAll_filenames
        ) :=    module
								export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
		export Promote_Mo_Eid(
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
				,boolean														pUseDelta						= false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames = //Filenames(pversion,pUseProd, pUseDelta).dbo_mo_Base.dAll_filenames	+ 
																									keynames(pversion,pUseProd, pUseDelta).mo_eid_key.dAll_filenames
        ) :=    module
								export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
		export Promote_Mo_v2_Eid(
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
				,boolean														pUseDelta						= false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames = //Filenames(pversion,pUseProd, pUseDelta).dbo_mo_Base.dAll_filenames	+ 
																									keynames(pversion,pUseProd, pUseDelta).mo_eid_v2_key.dAll_filenames
        ) :=    module
								export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
		export Promote_Wd_Body(
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
				,boolean														pUseDelta						= false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames = //Filenames(pversion,pUseProd, pUseDelta).dbo_mo_Base.dAll_filenames	+ 
																									keynames(pversion,pUseProd, pUseDelta).wd_body_key.dAll_filenames
        ) :=    module
								export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
		export Promote_Wd_Make(
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
				,boolean														pUseDelta						= false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames = //Filenames(pversion,pUseProd, pUseDelta).dbo_mo_Base.dAll_filenames	+ 
																									keynames(pversion,pUseProd, pUseDelta).wd_make_key.dAll_filenames
        ) :=    module
								export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
		export Promote_Wd_Model(
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
				,boolean														pUseDelta						= false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames = //Filenames(pversion,pUseProd, pUseDelta).dbo_mo_Base.dAll_filenames	+ 
																									keynames(pversion,pUseProd, pUseDelta).wd_model_key.dAll_filenames
        ) :=    module
								export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
		export Promote_Wd_Veh(
        string                              pversion            =  ''
        ,boolean                            pUseProd            = false
				,boolean														pUseDelta						= false
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
        ,dataset(lay_builds)    pBuildFilenames = //Filenames(pversion,pUseProd, pUseDelta).dbo_mo_Base.dAll_filenames	+ 
																									keynames(pversion,pUseProd, pUseDelta).wd_veh_key.dAll_filenames
        ) :=    module
								export buildfiles    := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
end;