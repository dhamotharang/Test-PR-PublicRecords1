//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Education_1,B_Education_2,CFG_Compile,E_Education FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Education(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_1(__in,__cfg).__ENH_Education_1) __ENH_Education_1 := B_Education_1(__in,__cfg).__ENH_Education_1;
  SHARED __EE5641371 := __ENH_Education_1;
  EXPORT __ENH_Education := __EE5641371;
END;
