﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Lien_Judgment_10,B_Lien_Judgment_5,CFG_Compile,E_Lien_Judgment FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Lien_Judgment_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_5(__in,__cfg).__ENH_Lien_Judgment_5) __ENH_Lien_Judgment_5 := B_Lien_Judgment_5(__in,__cfg).__ENH_Lien_Judgment_5;
  SHARED __EE889537 := __ENH_Lien_Judgment_5;
  EXPORT __ENH_Lien_Judgment_4 := __EE889537;
END;
