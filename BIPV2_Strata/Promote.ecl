import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote(
	 string								pversion				    = ''
	,string								pFilter					    = ''
	,boolean							pDelete					    = false
	,boolean							pIsTesting			    = false
	,dataset(lay_builds)	pBuildFilenames     = filenames	(pversion).dAll_filenames
	,boolean              pMove2DeleteSuper   = false //used for when moving a logical file into the built superfile(mod_Promote.fNew2Built). will place previous logical file into delete superfile.
  ,boolean              pIncludeBuiltDelete = false
	,string								pCleanupFilter			= ''
  ,boolean              pClearSuperFirst    = true
) :=
	tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting,,pClearSuperFirst,,pMove2DeleteSuper,pIncludeBuiltDelete,pCleanupFilter);
