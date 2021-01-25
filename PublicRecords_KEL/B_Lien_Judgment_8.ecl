//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Lien_Judgment_13,B_Lien_Judgment_9,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Lien_Judgment_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_9(__in,__cfg).__ENH_Lien_Judgment_9) __ENH_Lien_Judgment_9 := B_Lien_Judgment_9(__in,__cfg).__ENH_Lien_Judgment_9;
  SHARED __EE4812115 := __ENH_Lien_Judgment_9;
  EXPORT __ENH_Lien_Judgment_8 := __EE4812115;
END;
