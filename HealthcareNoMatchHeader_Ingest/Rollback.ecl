IMPORT	STD, tools;
///////////////////////////////////////////////////////////////////////////
// -- Works best when run on HTHOR
//////////////////////////////////////////////////////////////////////////

lay_builds 	:=	tools.Layout_FilenameVersions.builds;

EXPORT Rollback(  STRING              pSrc                = '',
                  STRING							pVersion					  =	'',
                  BOOLEAN							pDeleteFiles        =	FALSE,
                  BOOLEAN							pIsTesting				  =	FALSE,
                  STRING							pFilter						  =	''
                  )	:=	MODULE

	EXPORT	buildfiles	  :=	tools.mod_RollbackBuild(pversion, Filenames(pSrc,pVersion).dAll_filenames, pFilter, pDeleteFiles, pIsTesting);
	EXPORT	linkingfiles(STRING pIter)  :=	tools.mod_RollbackBuild(Filenames(pSrc,pVersion).Linking(pIter).getVersion, Filenames(pSrc,pVersion).Linking(pIter).dAll_filenames, pFilter, pDeleteFiles, pIsTesting);
  EXPORT  clearWorkmanFiles :=  IF(~pIsTesting AND STD.File.SuperFileExists(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).MasterWUOutput_SF),
                                  SEQUENTIAL(
                                    STD.File.StartSuperFileTransaction(),
                                    STD.File.DeleteSuperFile(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).MasterWUOutput_SF,TRUE),
                                    STD.File.FinishSuperFileTransaction()
                                  ),
                                  OUTPUT('Skipped Clearing Workman Files')
                                );


	EXPORT	fullbuild		:=	SEQUENTIAL(	
                            linkingfiles('5').Father2QA,
                            linkingfiles('4').Father2QA,
                            linkingfiles('3').Father2QA,
                            linkingfiles('2').Father2QA,
                            linkingfiles('1').Father2QA,
                            linkingfiles('0').Father2QA,
                            buildfiles.Father2QA,
                            clearWorkmanFiles
                          );

END;
