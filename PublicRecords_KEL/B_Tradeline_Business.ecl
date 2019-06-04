//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_Business_1,B_Tradeline_Business_3,CFG_Compile,E_Business,E_Tradeline,E_Tradeline_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_Business(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_Business_1(__in,__cfg).__ENH_Tradeline_Business_1) __ENH_Tradeline_Business_1 := B_Tradeline_Business_1(__in,__cfg).__ENH_Tradeline_Business_1;
  SHARED __EE799937 := __ENH_Tradeline_Business_1;
  EXPORT __ENH_Tradeline_Business := __EE799937;
END;
