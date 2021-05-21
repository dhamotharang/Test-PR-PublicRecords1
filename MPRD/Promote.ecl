import tools, versionControl, MPRD;
lay_builds 	:= tools.Layout_FilenameVersions.builds;

export Promote	:= module
	export Promote_individual(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   =   2 
		,dataset(lay_builds)	pBuildFilenames = 	MPRD.Filenames(pversion,pUseProd).individual_base.dAll_filenames) := module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
	end;
					
	export Promote_taxonomy_full_lu(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 	2 
		,dataset(lay_builds)	pBuildFilenames = 	MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_Base.dAll_filenames) := module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );			
		end;	
	 	
end;
