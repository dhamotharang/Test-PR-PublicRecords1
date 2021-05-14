IMPORT tools;

lay_builds := tools.Layout_FilenameVersions.builds;

EXPORT Promote_keys(	STRING							pVersion					=	'',
								STRING							pFilter						=	'',
								BOOLEAN							pDelete				 		=	TRUE,
								BOOLEAN							pIsTesting			 	=	FALSE,
								BOOLEAN							pClearFile				=	TRUE,
								BOOLEAN							pIsDeltaBuild			=	FALSE,
								DATASET(lay_builds)	pBuildFilenames 	=	utilfile.keynames(pversion).dAll_filenames)	:=	MODULE

EXPORT	buildfiles	:=	tools.mod_PromoteBuild(pVersion, pBuildFilenames, pFilter, pDelete,	pIsTesting,, pClearFile,,,,,pIsDeltaBuild);

END;