//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Education_2,CFG_Compile,E_Education FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Education_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_2(__in,__cfg).__ENH_Education_2) __ENH_Education_2 := B_Education_2(__in,__cfg).__ENH_Education_2;
  SHARED __EE4983990 := __ENH_Education_2;
  EXPORT __ENH_Education_1 := __EE4983990;
END;
