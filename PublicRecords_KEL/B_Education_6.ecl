//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Education_7,CFG_Compile,E_Education FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Education_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_7().__ENH_Education_7) __ENH_Education_7 := B_Education_7(__in,__cfg).__ENH_Education_7;
  SHARED __EE383449 := __ENH_Education_7;
  EXPORT __ENH_Education_6 := __EE383449;
END;
