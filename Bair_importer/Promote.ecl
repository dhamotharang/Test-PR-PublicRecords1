import tools,STD;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote :=
module
	export Promote_Event(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseEvent_dAll_filenames
		) :=    module
			export buildfiles := sequential(
					tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,3).new2built	
			);			
	end;
	
	export Promote_CFS(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseCFS_dAll_filenames
		) :=    module
			export buildfiles := sequential(
					tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,3).new2built	
			);			
	end;	
	
	export Promote_Crash(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseCrash_dAll_filenames
		) :=    module
			export buildfiles := sequential(
					tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,3).new2built	
			);					
	end;
	
	export Promote_Offender(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseOffenders_dAll_filenames
		) :=    module
			export buildfiles := sequential(
					tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,3).new2built	
			);			
		
	end;
	
	export Promote_LPR(
		 string								pversion				= 	''
		,boolean							pUseProd				= 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).baseLPR_dAll_filenames
		) :=    module
			export buildfiles := sequential(
					tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,3).new2built	
			);			
	end;	
	
end;
