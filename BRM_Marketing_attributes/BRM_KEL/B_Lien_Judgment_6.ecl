//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Lien_Judgment_10,B_Lien_Judgment_7,CFG_Compile,E_Lien_Judgment FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Lien_Judgment_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_7(__in,__cfg).__ENH_Lien_Judgment_7) __ENH_Lien_Judgment_7 := B_Lien_Judgment_7(__in,__cfg).__ENH_Lien_Judgment_7;
  SHARED __EE847482 := __ENH_Lien_Judgment_7;
  EXPORT __ENH_Lien_Judgment_6 := __EE847482;
END;
