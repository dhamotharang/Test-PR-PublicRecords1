import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Promote(string     pversion      =  ''
							,boolean    pUseProd      = false
							,boolean		pBaseFileType	= false
							,string     pFilter       = ''
							,boolean    pDelete       = true
							,boolean    pisTesting    = false
							,unsigned1  pnGenerations = 3
				):= MODULE
		
		export Promote_Accurint := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pversion, pUseProd).Accurint_Base.dAll_filenames
															,INQL_v2.keynames(pversion, pUseProd).Accurint_eid_key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
		export Promote_Custom := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pversion, pUseProd).Custom_Base.dAll_filenames
															,INQL_v2.keynames(pversion, pUseProd).Custom_eid_key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
		export Promote_Banko := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pversion, pUseProd).Banko_Base.dAll_filenames
															,INQL_v2.keynames(pversion, pUseProd).Banko_eid_key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
		export Promote_Batch := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pversion, pUseProd).Batch_Base.dAll_filenames
															,INQL_v2.keynames(pversion, pUseProd).Batch_eid_key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
		export Promote_BatchR3 := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pversion, pUseProd).BatchR3_Base.dAll_filenames
															,INQL_v2.keynames(pversion, pUseProd).BatchR3_eid_key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
		export Promote_Bridger := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pversion, pUseProd).Bridger_Base.dAll_filenames
															,INQL_v2.keynames(pversion, pUseProd).Bridger_eid_key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
		export Promote_Riskwise := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pversion, pUseProd).Riskwise_Base.dAll_filenames
															,INQL_v2.keynames(pversion, pUseProd).Riskwise_eid_key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
		export Promote_IDM := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pversion, pUseProd).IDM_Base.dAll_filenames
															,INQL_v2.keynames(pversion, pUseProd).IDM_eid_key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
		export Promote_SBA := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pversion, pUseProd).SBA_Base.dAll_filenames
															,INQL_v2.keynames(pversion, pUseProd).SBA_eid_key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
END;
