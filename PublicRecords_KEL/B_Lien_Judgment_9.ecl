﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Lien_Judgment_10,B_Lien_Judgment_13,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Lien_Judgment_9(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_10(__cfg).__ENH_Lien_Judgment_10) __ENH_Lien_Judgment_10 := B_Lien_Judgment_10(__cfg).__ENH_Lien_Judgment_10;
  SHARED __EE5226225 := __ENH_Lien_Judgment_10;
  EXPORT __ENH_Lien_Judgment_9 := __EE5226225;
END;
