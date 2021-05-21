//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Education_7,CFG_Compile,E_Education FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Education_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_7(__in,__cfg).__ENH_Education_7) __ENH_Education_7 := B_Education_7(__in,__cfg).__ENH_Education_7;
  SHARED __EE1930276 := __ENH_Education_7;
  EXPORT __ENH_Education_6 := __EE1930276;
END;
