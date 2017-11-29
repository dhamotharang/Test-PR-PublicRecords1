import tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

export Rollback(
	 string								pversion						=		''
	,boolean							pDeleteBuildFiles		= 	false
	,boolean							pIsTesting					= 	false
	,string								pFilter							= 	''
  ,string               pCluster            =   ''
	,dataset(lay_builds)	pBuildFilenames 		= 	keynames  (pversion,,pCluster).dall_filenames
) :=
  tools.mod_RollbackBuild(pversion,pBuildFilenames,pFilter,pDeleteBuildFiles,pIsTesting);

