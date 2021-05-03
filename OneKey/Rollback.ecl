IMPORT OneKey, tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

EXPORT Rollback(STRING pversion                         = ''
               ,BOOLEAN pDeleteInputFiles              = FALSE
               ,BOOLEAN pDeleteBuildFiles              = FALSE
               ,BOOLEAN pIsTesting                     = FALSE
               ,STRING pFilter                         = ''
               ,DATASET(lay_inputs) pInputFilenames    = OneKey.Filenames(pversion).dAll_Inputfilenames
               ,DATASET(lay_builds) pBuildFilenames    = OneKey.Filenames(pversion).dAll_Basefilenames
               ) := MODULE
	
  EXPORT inputfiles := tools.mod_RollbackInput(pInputFilenames,pFilter,pDeleteInputFiles,pIsTesting);
  EXPORT buildfiles := tools.mod_RollbackBuild(pversion,pBuildFilenames,pFilter,pDeleteBuildFiles,pIsTesting);
	
  EXPORT fullbuild := SEQUENTIAL(inputfiles.build2sprayed
                                ,buildfiles.Father2QA);
	
END;