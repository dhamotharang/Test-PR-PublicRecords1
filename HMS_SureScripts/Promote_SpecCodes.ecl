import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote_SpecCodes(
	 string								pversion				= 	''
	,boolean							pUseProd			= 	false
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pisTesting			= 	false
	,dataset(lay_builds)	pBuildFilenames = 	Filenames_SpecCodes(pversion,pUseProd).Base.dAll_filenames
																					//+ keynames	(pversion,pUseProd).dAll_filenames
) :=
module
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting);
	
end;
