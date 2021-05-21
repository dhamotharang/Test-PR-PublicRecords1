//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Education_6,B_Education_7,CFG_Compile,E_Education FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Education_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_6(__in,__cfg).__ENH_Education_6) __ENH_Education_6 := B_Education_6(__in,__cfg).__ENH_Education_6;
  SHARED __EE978007 := __ENH_Education_6;
  EXPORT __ENH_Education_5 := __EE978007;
END;
