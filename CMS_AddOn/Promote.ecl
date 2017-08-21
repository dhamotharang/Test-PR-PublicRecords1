IMPORT CMS_AddOn, tools;

lay_builds := tools.Layout_FilenameVersions.builds;

EXPORT Promote(
	STRING								pversion				= ''
	,BOOLEAN							pUseProd				= FALSE
	,STRING								pFilter					= ''
	,BOOLEAN							pDelete					= FALSE
	,BOOLEAN							pIsTesting			= FALSE
	,DATASET(lay_builds)	pBuildFilenames = CMS_AddOn.Filenames(pversion, pUseProd).Base.dAll_filenames) := MODULE

	EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion, pBuildFilenames, pFilter, pDelete, pIsTesting);

END;
