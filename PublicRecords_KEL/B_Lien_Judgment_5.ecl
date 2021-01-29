//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Lien_Judgment_13,B_Lien_Judgment_6,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Lien_Judgment_5(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_6(__cfg).__ENH_Lien_Judgment_6) __ENH_Lien_Judgment_6 := B_Lien_Judgment_6(__cfg).__ENH_Lien_Judgment_6;
  SHARED __EE5373896 := __ENH_Lien_Judgment_6;
  EXPORT __ENH_Lien_Judgment_5 := __EE5373896;
END;
