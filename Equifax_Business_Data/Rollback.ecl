import tools, Equifax_Business_Data;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

export Rollback(
	 string								pversion						=		''
	,boolean							pDeleteInputFiles		= 	false
	,boolean							pDeleteBuildFiles		= 	false
	,boolean							pIsTesting					= 	false
	,string								pFilter							= 	''
	,dataset(lay_inputs)	pInputFilenames 		= 	Filenames	(pversion).Input.dAll_filenames
	,dataset(lay_builds)	pBuildFilenames 		= 	Filenames	(pversion).dAll_filenames
																							+ keynames	(pversion).dAll_filenames
) :=
module
	
	export inputfiles	:= tools.mod_RollbackInput(pInputFilenames,pFilter,pDeleteInputFiles,pIsTesting);
	export buildfiles	:= tools.mod_RollbackBuild(pversion,pBuildFilenames,pFilter,pDeleteBuildFiles,pIsTesting);
	
	export fullbuild := sequential(
		 inputfiles.build2sprayed
		,buildfiles.Father2QA		
	);
	
end;