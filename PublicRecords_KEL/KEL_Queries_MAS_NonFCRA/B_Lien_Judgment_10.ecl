//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Lien_Judgment_11,B_Lien_Judgment_14,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Lien_Judgment_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_11(__in,__cfg).__ENH_Lien_Judgment_11) __ENH_Lien_Judgment_11 := B_Lien_Judgment_11(__in,__cfg).__ENH_Lien_Judgment_11;
  SHARED __EE3944482 := __ENH_Lien_Judgment_11;
  EXPORT __ENH_Lien_Judgment_10 := __EE3944482;
END;
