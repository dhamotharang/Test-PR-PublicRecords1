IMPORT tools;

lay_builds := tools.Layout_FilenameVersions.builds;
lay_inputs := tools.Layout_FilenameVersions.Inputs;

EXPORT Promote(STRING							 pversion				 	= '',
	             STRING							 pFilter				 	= '',
	             BOOLEAN						 pDelete				 	= FALSE,
	             BOOLEAN						 pIsTesting				= FALSE,
	             DATASET(lay_builds) pBuildFilenames 	= Filenames(pversion).dAll_filenames,
							 DATASET(lay_builds) pTMHistFilenames = Filenames(pversion).dAll_tmHist):= MODULE
	
	EXPORT buildfiles			:= tools.mod_PromoteBuild(pversion, pBuildFilenames, pFilter, pDelete, pIsTesting);
	EXPORT tmHistoryfiles	:= tools.mod_PromoteBuild(pversion, pTMHistFilenames, pFilter, pDelete, pIsTesting);

END;