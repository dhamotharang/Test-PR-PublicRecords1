import tools;
fbuildlayout := tools.Layout_FilenameVersions.builds;
export Rename_Keys(
	 string									pversion
	,string									pFilter						= ''
	,boolean								pJustKeys					= true	// only rename the keys(not files)?
	,boolean								pIsTesting				= true	// set to false to actually rename the keys
	,dataset(fbuildlayout)	pFilesToRename		= if(pJustKeys, keynames	(pversion).dall_filenames
																													, keynames	(pversion).dall_filenames
																													+ filenames	(pversion).dall_filenames
																							)
	,string									pSuperfileVersion	= 'qa'																								
) :=
	tools.fun_RenameBuildFiles(pversion,pFilesToRename,pIsTesting,pSuperfileVersion,pFilter);
