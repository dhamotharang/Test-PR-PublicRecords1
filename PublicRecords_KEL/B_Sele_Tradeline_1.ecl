﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Sele_Tradeline_2,B_Sele_Tradeline_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Tradeline_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Tradeline_2(__in,__cfg).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2(__in,__cfg).__ENH_Sele_Tradeline_2;
  SHARED __EE796047 := __ENH_Sele_Tradeline_2;
  EXPORT __ENH_Sele_Tradeline_1 := __EE796047;
END;
