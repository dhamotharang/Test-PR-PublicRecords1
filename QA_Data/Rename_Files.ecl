IMPORT versioncontrol;

fbuildlayout := versioncontrol.layout_versions.builds;

EXPORT Rename_Files(

	 STRING									pversion
	,STRING									pFilter						= ''
	,BOOLEAN								pIsTesting				= TRUE	// set to false to actually rename the files
	,DATASET(fbuildlayout)	pFilesToRename		= filenames	(pversion).dall_filenames
	,STRING									pSuperfileVersion	= 'qa'																								
) :=
FUNCTION

	filter	:= IF(pFilter = ''	,TRUE
															,REGEXFIND(pFilter,pFilesToRename.templatename,NOCASE)
						);
	
	dfilenames_filtered := pFilesToRename(filter);

	RETURN VersionControl.fRename_BuildFiles(pversion,dfilenames_filtered,pIsTesting,pSuperfileVersion);

END;

