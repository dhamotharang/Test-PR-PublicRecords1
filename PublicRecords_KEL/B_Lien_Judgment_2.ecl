//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Lien_Judgment_12,B_Lien_Judgment_3,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Lien_Judgment_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_3(__in,__cfg).__ENH_Lien_Judgment_3) __ENH_Lien_Judgment_3 := B_Lien_Judgment_3(__in,__cfg).__ENH_Lien_Judgment_3;
  SHARED __EE4454078 := __ENH_Lien_Judgment_3;
  EXPORT __ENH_Lien_Judgment_2 := __EE4454078;
END;
