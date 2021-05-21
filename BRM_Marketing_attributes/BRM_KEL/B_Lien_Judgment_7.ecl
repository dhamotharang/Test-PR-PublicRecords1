//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Lien_Judgment_10,B_Lien_Judgment_8,CFG_Compile,E_Lien_Judgment FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Lien_Judgment_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_8(__in,__cfg).__ENH_Lien_Judgment_8) __ENH_Lien_Judgment_8 := B_Lien_Judgment_8(__in,__cfg).__ENH_Lien_Judgment_8;
  SHARED __EE828305 := __ENH_Lien_Judgment_8;
  EXPORT __ENH_Lien_Judgment_7 := __EE828305;
END;
