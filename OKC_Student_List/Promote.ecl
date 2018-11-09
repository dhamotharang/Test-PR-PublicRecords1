IMPORT tools;

lay_builds := tools.Layout_FilenameVersions.builds;
lay_inputs := tools.Layout_FilenameVersions.Inputs;

EXPORT Promote(	STRING							pVersion					=	'',
								STRING							pFilter						=	'',
								BOOLEAN							pDelete				 		=	TRUE,				//** Change to TRUE when going into production
								BOOLEAN							pIsTesting			 	=	FALSE,
								BOOLEAN							pClearFile				=	TRUE,
								BOOLEAN							pIsDeltaBuild			=	FALSE,
								DATASET(lay_inputs)	pInputFilenames 	=	Filenames(pversion).Input.dAll_filenames,
								DATASET(lay_builds)	pBuildFilenames 	=	Filenames(pversion).dAll_filenames)	:=	MODULE
	
	EXPORT	inputfiles	:=	tools.mod_PromoteInput(pVersion, pInputFilenames, pFilter, pDelete, pIsTesting, pClearFile);
	EXPORT	buildfiles	:=	tools.mod_PromoteBuild(pVersion, pBuildFilenames, pFilter, pDelete,	pIsTesting,, pClearFile);

END;