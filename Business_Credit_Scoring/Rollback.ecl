IMPORT	tools;
///////////////////////////////////////////////////////////////////////////
// -- Works best when run on HTHOR
//////////////////////////////////////////////////////////////////////////

lay_builds 	:=	tools.Layout_FilenameVersions.builds;

EXPORT Rollback(STRING							pVersion					=	'',
								BOOLEAN							pDeleteInputFiles	=	FALSE,
								BOOLEAN							pDeleteBuildFiles	=	FALSE,
							  BOOLEAN							pIsTesting				=	FALSE,
								STRING							pFilter						=	'',
								DATASET(lay_builds)	pBuildFilenames 	=	Filenames(pversion).dAll_filenames +
																												Keynames(pversion).dAll_filenames)	:=	MODULE

	EXPORT	buildfiles	:=	tools.mod_RollbackBuild(pversion, pBuildFilenames, pFilter, pDeleteBuildFiles, pIsTesting);

	EXPORT	fullbuild		:=	SEQUENTIAL(	buildfiles.Father2QA);

END;