IMPORT tools, OneKey;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

EXPORT Promote(
  STRING                 pversion = ''
 ,STRING                 pFilter = ''
 ,BOOLEAN                pDelete = FALSE
 ,BOOLEAN                pIsTesting = FALSE
 ,DATASET(lay_inputs)    pInputFilenames = OneKey.Filenames(pversion).dAll_Inputfilenames
 ,DATASET(lay_builds)    pBuildFilenames = OneKey.Filenames(pversion).dAll_Basefilenames // + Keynames(pversion).dAll_filenames
) := MODULE
	
  EXPORT inputfiles := tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
  EXPORT buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);

END;
