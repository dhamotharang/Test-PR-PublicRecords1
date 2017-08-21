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
function

	filter	:= if(pFilter = ''	,true
															,regexfind(pFilter,pFilesToRename.templatename,nocase)
						);
	
	dfilenames_filtered := pFilesToRename(filter);

	return tools.fun_RenameBuildFiles(pversion,dfilenames_filtered,pIsTesting,pSuperfileVersion);

end;

