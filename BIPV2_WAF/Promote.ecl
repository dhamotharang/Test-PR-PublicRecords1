import tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

export Promote(
	 string								pversion						= 	''
	,string								pFilter							= 	''
	,boolean							pDelete							= 	false
	,boolean							pIsTesting					= 	false
	,dataset(lay_builds)	pBuildKeyFilenames 	= 	keynames	(pversion).dAll_filenames
	,dataset(lay_builds)	pBuildBaseFilenames = 	FileNames	(pversion).dAll_filenames
) :=

module
	
	export buildKeyfiles	:= tools.mod_PromoteBuild(pversion,pBuildKeyFilenames,pFilter,pDelete,pIsTesting);
	export buildBasefiles	:= tools.mod_PromoteBuild(pversion,pBuildBaseFilenames,pFilter,pDelete,pIsTesting);
	
end;