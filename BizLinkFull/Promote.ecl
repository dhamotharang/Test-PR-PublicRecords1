import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote(
	 string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pIsTesting			= 	false
  ,string               pCluster        =   ''
	,dataset(lay_builds)	pBuildFilenames = 	keynames	(pversion,,pCluster).dAll_filenames
) :=
	tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);

