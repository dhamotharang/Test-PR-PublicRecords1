IMPORT tools,LN_PropertyV2_Fast;

lay_builds := tools.Layout_FilenameVersions.builds;
mostcurrentlog := SORT(LN_PropertyV2_Fast.BuildLogger.file(key_build_end_date<>''),-version)[1] : INDEPENDENT;

EXPORT Promote(STRING pversion        = '',
  STRING              pFilter         = '',
  BOOLEAN             pDelete         = TRUE,
  BOOLEAN             pIsTesting      = FALSE,
  BOOLEAN             pClearFile      = FALSE,
  BOOLEAN							pIsDeltaBuild	  = IF(mostcurrentlog.update_type = 'FULL',FALSE,TRUE),
  DATASET(lay_builds) pBuildFilenames = LN_PropertyV2_Fast.Keynames(pversion).dAll_filenames) := MODULE

  EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion, pBuildFilenames, pFilter, IF(pIsDeltaBuild, TRUE, FALSE), pIsTesting, , pClearFile, , , , , pIsDeltaBuild);

END;