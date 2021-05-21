//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Education_6,B_Education_7,CFG_Compile,E_Education FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Education_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_6(__in,__cfg).__ENH_Education_6) __ENH_Education_6 := B_Education_6(__in,__cfg).__ENH_Education_6;
  SHARED __EE1643063 := __ENH_Education_6;
  EXPORT __ENH_Education_5 := __EE1643063;
END;
