import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote(
	 string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pIsTesting			= 	false
	,dataset(lay_builds)	pBuildFilenames = 	Filenames	(pversion).dAll_filenames
																					+ keynames	(pversion).dAll_filenames
) :=
	tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);
