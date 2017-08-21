IMPORT tools;

lay_builds := tools.Layout_FilenameVersions.builds;
lay_inputs := tools.Layout_FilenameVersions.Inputs;

EXPORT Promote(STRING							 pversion				 = '',
							 BOOLEAN						 pUseProd				 = FALSE,
	             STRING							 pFilter				 = '',
	             BOOLEAN						 pDelete				 = FALSE,
	             BOOLEAN						 pIsTesting			 = FALSE,
	             DATASET(lay_builds) pBuildFilenames = Filenames(pversion, puseprod).dAll_filenames) := MODULE
	
	EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion, pBuildFilenames, pFilter, pDelete, pIsTesting);

END;