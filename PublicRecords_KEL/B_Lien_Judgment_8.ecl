//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Lien_Judgment_11,B_Lien_Judgment_9,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Lien_Judgment_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_9(__in,__cfg).__ENH_Lien_Judgment_9) __ENH_Lien_Judgment_9 := B_Lien_Judgment_9(__in,__cfg).__ENH_Lien_Judgment_9;
  SHARED __EE193418 := __ENH_Lien_Judgment_9;
  EXPORT __ENH_Lien_Judgment_8 := __EE193418;
END;
