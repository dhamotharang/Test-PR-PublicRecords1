//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Lien_Judgment_13,B_Lien_Judgment_5,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Lien_Judgment_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_5(__in,__cfg).__ENH_Lien_Judgment_5) __ENH_Lien_Judgment_5 := B_Lien_Judgment_5(__in,__cfg).__ENH_Lien_Judgment_5;
  SHARED __EE1132537 := __ENH_Lien_Judgment_5;
  EXPORT __ENH_Lien_Judgment_4 := __EE1132537;
END;
