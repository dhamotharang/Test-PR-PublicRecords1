IMPORT tools, OneKey;

EXPORT Build_Base(
  STRING                                          pversion
 ,BOOLEAN                                         pIsTesting      = FALSE
 ,DATASET(OneKey.Layouts.InputA.Sprayed)          pSprayedFileA   = OneKey.Files().InputA.using
 ,DATASET(OneKey.Layouts.InputB.Sprayed)          pSprayedFileB   = OneKey.Files().InputB.using
 ,DATASET(OneKey.Layouts.Base)                    pBaseFile       = OneKey.Files().base.qa	
 ,DATASET(OneKey.Layouts.Base)                    pNewBaseFile    = OneKey.Update_Base(pversion, pSprayedFileA, pSprayedFileB, pBaseFile)
 ,BOOLEAN                                         pWriteFileOnly  = FALSE
) := FUNCTION

	tools.mac_WriteFile(OneKey.Filenames(pversion).base.new, pNewBaseFile, Build_Base_File, pShouldExport := FALSE);

	RETURN
		IF(tools.fun_IsValidVersion(pversion)
			,SEQUENTIAL(IF(NOT pWriteFileOnly, OneKey.Promote().Inputfiles.Sprayed2Using)
				         ,Build_Base_File
				         ,IF(NOT pWriteFileOnly, OneKey.Promote(pversion).buildfiles.New2Built))		
			,OUTPUT('No Valid version parameter passed, skipping OneKey.Build_Base attribute'));
		
END;