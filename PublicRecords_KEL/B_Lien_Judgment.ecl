//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Lien_Judgment_1,B_Lien_Judgment_12,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Lien_Judgment(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_1(__in,__cfg).__ENH_Lien_Judgment_1) __ENH_Lien_Judgment_1 := B_Lien_Judgment_1(__in,__cfg).__ENH_Lien_Judgment_1;
  SHARED __EE5724950 := __ENH_Lien_Judgment_1;
  EXPORT __ENH_Lien_Judgment := __EE5724950;
END;
