//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Professional_License_2,B_Professional_License_4,CFG_Compile,E_Professional_License FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Professional_License_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Professional_License_2(__in,__cfg).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2(__in,__cfg).__ENH_Professional_License_2;
  SHARED __EE796030 := __ENH_Professional_License_2;
  EXPORT __ENH_Professional_License_1 := __EE796030;
END;
