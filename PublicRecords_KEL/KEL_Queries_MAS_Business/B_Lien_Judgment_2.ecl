//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Lien_Judgment_12,B_Lien_Judgment_3,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL15.Null;
EXPORT B_Lien_Judgment_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_3(__in,__cfg).__ENH_Lien_Judgment_3) __ENH_Lien_Judgment_3 := B_Lien_Judgment_3(__in,__cfg).__ENH_Lien_Judgment_3;
  SHARED __EE2863002 := __ENH_Lien_Judgment_3;
  EXPORT __ENH_Lien_Judgment_2 := __EE2863002;
END;
