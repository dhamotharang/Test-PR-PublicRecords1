//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_Business_3,CFG_Compile,E_Business,E_Tradeline,E_Tradeline_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_Business_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_Business_3(__in,__cfg).__ENH_Tradeline_Business_3) __ENH_Tradeline_Business_3 := B_Tradeline_Business_3(__in,__cfg).__ENH_Tradeline_Business_3;
  SHARED __EE394493 := __ENH_Tradeline_Business_3;
  EXPORT __ENH_Tradeline_Business_2 := __EE394493;
END;
