//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Lien_Judgment_12,B_Lien_Judgment_9,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Lien_Judgment_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_9(__in,__cfg).__ENH_Lien_Judgment_9) __ENH_Lien_Judgment_9 := B_Lien_Judgment_9(__in,__cfg).__ENH_Lien_Judgment_9;
  SHARED __EE1892884 := __ENH_Lien_Judgment_9;
  EXPORT __ENH_Lien_Judgment_8 := __EE1892884;
END;
