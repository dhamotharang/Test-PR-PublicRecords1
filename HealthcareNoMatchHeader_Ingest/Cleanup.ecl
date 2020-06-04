IMPORT	STD, tools;
///////////////////////////////////////////////////////////////////////////
// -- Works best when run on HTHOR
//////////////////////////////////////////////////////////////////////////

lay_super 	:=	tools.Layout_FilenameVersions.builds;
lay_logical :=  STD.File.FsLogicalFileInfoRecord;

EXPORT Cleanup( STRING                pSrc              = '',
                STRING							  pVersion          = '',
                DATASET(lay_super)    pSuperFiles       = Filenames(pSrc,pVersion).dAllSuperFiles,
                DATASET(lay_logical)  pLogicalFiles     = Filenames(pSrc,pVersion).dAllLogicalFiles,
                BOOLEAN               pDeleteSuperFiles = TRUE,
                BOOLEAN               pIsTesting        = FALSE
              )	:=	MODULE

  SHARED  SuperFilenames      :=  PROJECT(pSuperFiles.dSuperfiles,TRANSFORM({STRING name},SELF.name:=TRIM(LEFT.name,ALL)));
  SHARED  LogicalFilenames    :=  PROJECT(pLogicalFiles,TRANSFORM({STRING name},SELF.name:=TRIM(LEFT.name,ALL)));
  SHARED  allFilenames        :=  SuperFilenames+LogicalFilenames;
          
  EXPORT  deleteSuperFiles    :=  NOTHOR(APPLY(pSuperFiles, APPLY(dSuperfiles, tools.mod_Utilities.removesuper(TRIM(name,ALL),pDeleteSuperFiles))));
  EXPORT  deleteLogicalFiles  :=  NOTHOR(APPLY(pLogicalFiles(~superfile), tools.mod_Utilities.DeleteLogical(TRIM(name,ALL))));
  
  EXPORT  deleteAllFiles := ORDERED(
                              OUTPUT(allFilenames,ALL,NAMED('AllFilenames')),
                              IF(~pIsTesting,
                                ORDERED(
                                  deleteSuperFiles,
                                  deleteLogicalFiles
                                )
                              )
                            );
END;
