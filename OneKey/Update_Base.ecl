IMPORT business_header, OneKey;

EXPORT Update_Base(STRING                                    pversion
                  ,DATASET(OneKey.Layouts.InputA.Sprayed)    pSprayedFileA = OneKey.Files().InputA.using
                  ,DATASET(OneKey.Layouts.InputB.Sprayed)    pSprayedFileB = OneKey.Files().InputB.using
                  ,DATASET(OneKey.Layouts.Base)              pBaseFile     = OneKey.Files().base.qa
                  ,BOOLEAN                                   pShouldUpdate = OneKey._Flags.ShouldUpdate) := FUNCTION

  dStandardizedInputFiles   := OneKey.Standardize_Input.fAll(pSprayedFileA, pversion);
	
  base_file                 := PROJECT(pBaseFile, TRANSFORM(OneKey.Layouts.Base, SELF.record_type := 'H'; SELF := LEFT));
	
  update_combined           := IF(pShouldUpdate
                                 ,dStandardizedInputFiles + base_file
                                 ,dStandardizedInputFiles);

  dStandardize_NameAddr     := OneKey.Standardize_NameAddr.fAll(update_combined, pversion);
  dAppendIds                := OneKey.Append_Ids.fAll(dStandardize_NameAddr);
  dRollup                   := OneKey.Rollup_Base(dAppendIds);

  dStandardize_FileB        := OneKey.Standardize_FileB.fAll(pSprayedFileB, pversion);
  dUpdatedBase              := OneKey.Append_FileB(dRollup, dStandardize_FileB);
  
  RETURN dUpdatedBase;

END;