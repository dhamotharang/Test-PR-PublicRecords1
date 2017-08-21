IMPORT tools;

lay_builds := tools.Layout_FilenameVersions.builds;
lay_inputs := tools.Layout_FilenameVersions.Inputs;

EXPORT Promote(	STRING							pVersion					=	'',
								STRING							pFilter						=	'',
								BOOLEAN							pDelete				 		=	TRUE,
								BOOLEAN							pIsTesting			 	=	FALSE,
								BOOLEAN							pClearFile				=	TRUE,
								BOOLEAN							pIsDeltaBuild			=	FALSE,
								DATASET(lay_builds)	pBuildFilenames 	=	Keynames(pversion).dAll_filenames
																												// +	Keynames(pversion,,TRUE).dAll_filenames // FCRA Keys
																												)	:=	MODULE
	
	EXPORT	buildfiles	:=	tools.mod_PromoteBuild(pVersion, pBuildFilenames, pFilter, pDelete,	pIsTesting,,pClearFile,,,,,pIsDeltaBuild);

END;