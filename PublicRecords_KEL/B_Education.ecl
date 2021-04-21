//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Education_1,B_Education_3,CFG_Compile,E_Education FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Education(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_1(__in,__cfg).__ENH_Education_1) __ENH_Education_1 := B_Education_1(__in,__cfg).__ENH_Education_1;
  SHARED __EE11372554 := __ENH_Education_1;
  EXPORT __ENH_Education := __EE11372554;
END;
