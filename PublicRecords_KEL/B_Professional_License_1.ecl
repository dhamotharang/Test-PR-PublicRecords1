//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Professional_License_2,B_Professional_License_4,CFG_Compile,E_Professional_License FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Professional_License_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Professional_License_2(__in,__cfg).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2(__in,__cfg).__ENH_Professional_License_2;
  SHARED __EE1762750 := __ENH_Professional_License_2;
  EXPORT __ENH_Professional_License_1 := __EE1762750;
END;
