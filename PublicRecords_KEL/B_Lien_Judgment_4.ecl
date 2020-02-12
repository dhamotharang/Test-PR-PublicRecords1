//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Lien_Judgment_5,B_Lien_Judgment_6,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Lien_Judgment_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_5(__in,__cfg).__ENH_Lien_Judgment_5) __ENH_Lien_Judgment_5 := B_Lien_Judgment_5(__in,__cfg).__ENH_Lien_Judgment_5;
  SHARED __EE279756 := __ENH_Lien_Judgment_5;
  EXPORT __ENH_Lien_Judgment_4 := __EE279756;
END;
