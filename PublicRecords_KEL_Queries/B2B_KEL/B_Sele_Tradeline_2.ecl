﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_Tradeline_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL_Queries.B2B_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Tradeline_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3;
  SHARED __EE619857 := __ENH_Sele_Tradeline_3;
  EXPORT __ENH_Sele_Tradeline_2 := __EE619857;
END;
