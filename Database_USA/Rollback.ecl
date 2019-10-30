IMPORT tools, dx_Database_USA;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

EXPORT Rollback(
	 STRING								pversion						=		''
	,BOOLEAN							pDeleteInputFiles		= 	FALSE
	,BOOLEAN							pDeleteBuildFiles		= 	FALSE
	,BOOLEAN							pIsTesting					= 	FALSE
	,STRING								pFilter							= 	''
	,DATASET(lay_inputs)	pInputFilenames 		= 	Database_USA.Filenames(pversion).Input.dAll_filenames 
	,DATASET(lay_builds)	pBuildFilenames 		= 	Database_USA.Filenames(pversion).dAll_filenames +
	                                              dx_Database_USA.Names(pversion).dAll_filenames
) :=
MODULE
	
	EXPORT inputfiles	:= tools.mod_RollbackInput(pInputFilenames,pFilter,pDeleteInputFiles,pIsTesting);
	EXPORT buildfiles	:= tools.mod_RollbackBuild(pversion,pBuildFilenames,pFilter,pDeleteBuildFiles,pIsTesting);
	
	EXPORT fullbuild := SEQUENTIAL(
		 inputfiles.build2sprayed
		,buildfiles.Father2QA		
	);
	
END;