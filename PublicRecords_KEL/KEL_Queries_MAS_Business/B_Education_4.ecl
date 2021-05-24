//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Education_5,B_Education_7,CFG_Compile,E_Education FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Education_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_5(__in,__cfg).__ENH_Education_5) __ENH_Education_5 := B_Education_5(__in,__cfg).__ENH_Education_5;
  SHARED __EE2116526 := __ENH_Education_5;
  EXPORT __ENH_Education_4 := __EE2116526;
END;
