import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Promote(string     pVersion      =  ''
							,boolean    fcra      		= false
							,boolean    pDaily      	= false							
							,boolean		pBaseFileType	= false
							,string     pFilter       = ''
							,boolean    pDelete       = true
							,boolean    pisTesting    = false
							,unsigned1  pnGenerations = 3
				):= MODULE
		
		export INQL := module		
	
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pVersion, fcra, pDaily).INQL_Base.dAll_filenames
															,INQL_v2.keynames(pDaily, fcra, pVersion).dAll_filenames
															);
															
			export buildfiles := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete,pisTesting := false);//, pnGenerations := 3);    
		end;
		
    export INQL_DidVille := module				
			dataset(lay_builds)  pBuildFilenames := INQL_v2.Filenames(pVersion,  fcra, pDaily).INQL_Base_DIDVille.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete,pisTesting := false);//, pnGenerations := 3);    
		end;		
		
		
		export SBA := module				
			dataset(lay_builds)  pBuildFilenames := INQL_v2.Filenames(pVersion, fcra, pDaily).SBA_Base.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete,pisTesting := false);//, pnGenerations := 3);    
		end;
		
		export Batch_PIIs := module				
			dataset(lay_builds)  pBuildFilenames := INQL_v2.Filenames(pVersion, fcra, pdaily).Batch_PIIs_Base.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete,pisTesting := false);//, pnGenerations := 3);    
		end;	

		export BillGroups_DID := module				
			dataset(lay_builds)  pBuildFilenames := INQL_v2.Filenames(pVersion, fcra, pDaily).BillGroups_DID_Base.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete,pisTesting := false);//, pnGenerations := 3);    
		end;		
		
		export MBS_Deconfliction := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pVersion, fcra).MBS_Deconfliction_Base.dAll_filenames
															// ,INQL_v2.keynames(pVersion, fcra).INQL_Key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
		export MBS_Transaction := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
															,INQL_v2.Filenames(pVersion, fcra).MBS_Transaction_Base.dAll_filenames
															// ,INQL_v2.keynames(pVersion, fcra).INQL_Key.dAll_filenames
															);
			export buildfiles := tools.mod_PromoteBuild(pVersion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
		end;
		
END;
