IMPORT Strata, OneKey;

EXPORT Strata_Stats(DATASET(OneKey.Layouts.Base) pBaseFile                     = OneKey.Files().Base.Built
                   ,STRING pfileversion                                        = 'using'
                   ,BOOLEAN pUseOtherEnviron                                   = OneKey._Constants().IsDataland
                   ,DATASET(OneKey.Layouts.InputA.Sprayed) pSprayedFileA       = OneKey.Files(pfileversion, pUseOtherEnviron).InputA.logical
                   ,DATASET(OneKey.Layouts.InputB.Sprayed) pSprayedFileB       = OneKey.Files(pfileversion, pUseOtherEnviron).InputB.logical	
                   ) := MODULE

  Strata.mac_Pops   (pSprayedFileA, dInputANoGrouping);
  Strata.mac_Uniques(pSprayedFileA, dUniqueInputANoGrouping);
  Strata.mac_Pops   (pSprayedFileB, dInputBNoGrouping);
  Strata.mac_Uniques(pSprayedFileB, dUniqueInputBNoGrouping);
  Strata.mac_Pops   (pBaseFile,     dNoGrouping);
  Strata.mac_Pops   (pBaseFile,     dCleanAddressState,       'st');
  Strata.mac_Uniques(pBaseFile,     dUniqueNoGrouping, , , , FALSE, ['bdid','source_rec_id','UltID','OrgID','ProxID','SELEID','POWID','EmpID','DotID']);
  Strata.mac_Uniques(pBaseFile,     dUniqueCleanAddressState, 'st', , , FALSE, ['bdid','source_rec_id','UltID','OrgID','ProxID','SELEID','POWID','EmpID','DotID']);
  
END;