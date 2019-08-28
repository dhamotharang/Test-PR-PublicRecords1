import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export _Promote(
	 string								pversion				    = 	''
	,string								pFilter					    = 	''
	,boolean							pDelete					    = 	false
	,boolean							pIsTesting			    = 	false
	,dataset(lay_builds)	pBuildFilenames     = 	_Filenames	(pversion).dAll_filenames
  ,string               pOddFilename        = ''
	,boolean              pMove2DeleteSuper   = false //used for when moving a logical file into the built superfile(mod_Promote.fNew2Built). will place previous logical file into delete superfile.
  ,boolean              pIncludeBuiltDelete = false
	,string								pCleanupFilter			= ''
) :=
	tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting,,,pOddFilename,pMove2DeleteSuper,pIncludeBuiltDelete,pCleanupFilter);
