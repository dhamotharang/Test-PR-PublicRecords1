//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Lien_Judgment_1,B_Lien_Judgment_12,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Lien_Judgment(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_1().__ENH_Lien_Judgment_1) __ENH_Lien_Judgment_1 := B_Lien_Judgment_1(__in,__cfg).__ENH_Lien_Judgment_1;
  SHARED __EE4354139 := __ENH_Lien_Judgment_1;
  EXPORT __ENH_Lien_Judgment := __EE4354139;
END;
