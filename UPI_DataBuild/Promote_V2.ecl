import tools;
lay_builds     := tools.Layout_FilenameVersions.builds;

export Promote_V2  := module
    
    export Promote_base(
        string                              pVersion
        ,boolean                            pUseProd
				,string															gcid
				,string															pHistMode
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
       ,dataset(lay_builds)    pBuildFilenames =     Filenames_V2(pVersion,pUseProd,gcid,pHistMode).member_base.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
    export Promote_processed_input(
        string                              pVersion
        ,boolean                            pUseProd
				,string															gcid
				,string															pHistMode
        ,string                             pFilter							= ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
       ,dataset(lay_builds)    pBuildFilenames =     Filenames_V2(pVersion,pUseProd,gcid,pHistMode).processed_input.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
    export Promote_return_tobatch(
        string                              pVersion
        ,boolean                            pUseProd
				,string															gcid
				,string															pHistMode
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
       ,dataset(lay_builds)    pBuildFilenames =     Filenames_V2(pVersion,pUseProd,gcid,pHistMode).tobatch_file.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
    export Promote_tobatch_metrics(
        string                              pVersion
        ,boolean                            pUseProd
				,string															gcid
				,string															pHistMode
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
       ,dataset(lay_builds)    pBuildFilenames =     Filenames_V2(pVersion,pUseProd,gcid,pHistMode).tobatch_metrics_file.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
    export Promote_asHeader(
        string                              pVersion
        ,boolean                            pUseProd
				,string															gcid
				,string															pHistMode
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
			 ,dataset(lay_builds)		 pBuildFilenames		 =		 Filenames_V2(pVersion,pUseProd,gcid,pHistMode).asHeader.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
    export Promote_temp_header(
        string                              pVersion
        ,boolean                            pUseProd
				,string															gcid
				,string															pHistMode
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
			 ,dataset(lay_builds)		 pBuildFilenames		 =		 Filenames_V2(pVersion,pUseProd,gcid,pHistMode).temp_header.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;
		
    export Promote_aggregate(
        string                              pVersion
        ,boolean                            pUseProd
				,string															gcid
				,string															pHistMode
        ,string                             pFilter             = ''
        ,boolean                            pDelete             = false
        ,boolean                            pisTesting          = false
        ,unsigned1                          pnGenerations       = 3                           
       ,dataset(lay_builds)    pBuildFilenames =     Filenames_V2(pVersion,pUseProd,gcid,pHistMode).aggregate_report_file.dAll_filenames
        ) :=    module
            export buildfiles    := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete := true,pisTesting := false, pnGenerations := 2);
    
    end;		
		    
end;
