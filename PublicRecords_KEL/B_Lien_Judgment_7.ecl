﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Lien_Judgment_12,B_Lien_Judgment_8,CFG_Compile,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Lien_Judgment_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Lien_Judgment_8().__ENH_Lien_Judgment_8) __ENH_Lien_Judgment_8 := B_Lien_Judgment_8(__in,__cfg).__ENH_Lien_Judgment_8;
  SHARED __EE288054 := __ENH_Lien_Judgment_8;
  EXPORT __ENH_Lien_Judgment_7 := __EE288054;
END;
