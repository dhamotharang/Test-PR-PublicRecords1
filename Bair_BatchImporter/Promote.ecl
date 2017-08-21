import tools,STD;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote :=
module
	export Promote_Common(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	true
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseCommon_dAll_filenames
		) :=    module
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
	end;
	
	export Promote_Event(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	true
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseEvent_dAll_filenames
		) :=    module
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
	end;
	
	export Promote_CFS(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	true
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseCFS_dAll_filenames
		) :=    module
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
	end;	
	
	export Promote_Crash(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	true
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseCrash_dAll_filenames
		) :=    module
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
	end;
	
	export Promote_Offender(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	true
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseOffenders_dAll_filenames
		) :=    module
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);		
		
	end;
	
	export Promote_LPR(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	true
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseLPR_dAll_filenames
		) :=    module
			export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);			
	end;	
	
end;
