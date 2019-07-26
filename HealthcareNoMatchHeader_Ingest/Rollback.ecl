IMPORT	tools;
///////////////////////////////////////////////////////////////////////////
// -- Works best when run on HTHOR
//////////////////////////////////////////////////////////////////////////

lay_builds 	:=	tools.Layout_FilenameVersions.builds;

EXPORT Rollback(  STRING              pSrc                = '',
                  STRING							pVersion					  =	'',
                  STRING              pIter               = '1',
                  BOOLEAN							pDeleteBuildFiles	  =	FALSE,
                  BOOLEAN							pDeleteLinkingFiles	=	FALSE,
                  BOOLEAN							pIsTesting				  =	FALSE,
                  STRING							pFilter						  =	'',
                  DATASET(lay_builds)	pBuildFilenames 	  =	Filenames(pSrc,pVersion).dAll_filenames,
                  DATASET(lay_builds)	pLinkingFilenames   =	Filenames(pSrc,pVersion).Linking(pIter).dAll_filenames)	:=	MODULE

  SHARED  pLinkingVersion :=  Filenames(pSrc,pVersion).Linking(pIter).getVersion;
	EXPORT	buildfiles	  :=	tools.mod_RollbackBuild(pversion, pBuildFilenames, pFilter, pDeleteBuildFiles, pIsTesting);
	EXPORT	linkingfiles  :=	tools.mod_RollbackBuild(pLinkingVersion, pLinkingFilenames, pFilter, pDeleteLinkingFiles, pIsTesting);

	EXPORT	fullbuild		:=	SEQUENTIAL(	
                            buildfiles.Father2QA,
                            linkingfiles.Father2QA
                          );

END;