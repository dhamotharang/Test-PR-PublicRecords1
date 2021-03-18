//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Lien_Judgment_12,B_Lien_Judgment_13,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Lien_Judgment_11(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_12(__in,__cfg).__ENH_Lien_Judgment_12) __ENH_Lien_Judgment_12 := B_Lien_Judgment_12(__in,__cfg).__ENH_Lien_Judgment_12;
  SHARED __EE5381352 := __ENH_Lien_Judgment_12;
  EXPORT __ENH_Lien_Judgment_11 := __EE5381352;
END;
