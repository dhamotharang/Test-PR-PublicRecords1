//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Lien_Judgment_11,B_Lien_Judgment_13,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Lien_Judgment_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_11(__in,__cfg).__ENH_Lien_Judgment_11) __ENH_Lien_Judgment_11 := B_Lien_Judgment_11(__in,__cfg).__ENH_Lien_Judgment_11;
  SHARED __EE1583079 := __ENH_Lien_Judgment_11;
  EXPORT __ENH_Lien_Judgment_10 := __EE1583079;
END;
