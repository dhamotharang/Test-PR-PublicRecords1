IMPORT HealthcareNoMatchHeader_Ingest,tools;

lay_builds := tools.Layout_FilenameVersions.builds;
lay_inputs := tools.Layout_FilenameVersions.Inputs;

EXPORT Promote(	STRING              pSrc              = '',
                STRING							pVersion					=	'',
                STRING              pIter             = '1',
								STRING							pFilter						=	'',
								BOOLEAN							pDelete				 		=	TRUE,
								BOOLEAN							pIsTesting			 	=	FALSE,
								BOOLEAN							pClearFile				=	TRUE,
								DATASET(lay_builds)	pBuildFilenames 	  =	Filenames(pSrc,pVersion).dAll_filenames,
								DATASET(lay_builds)	pLinkingFilenames   =	Filenames(pSrc,pVersion).Linking(pIter).dAll_filenames)	:=	MODULE
	
  SHARED  pLinkingVersion :=  Filenames(pSrc,pVersion).Linking(pIter).getVersion;
	EXPORT	buildfiles	    :=	tools.mod_PromoteBuild(pVersion, pBuildFilenames, pFilter, pDelete,	pIsTesting,, pClearFile);
	EXPORT	linkingfiles	  :=	tools.mod_PromoteBuild(pLinkingVersion, pLinkingFilenames, pFilter, pDelete,	pIsTesting,, pClearFile);

END;