//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Professional_License_3,B_Professional_License_4,CFG_Compile,E_Professional_License FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Professional_License_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3;
  SHARED __EE5420548 := __ENH_Professional_License_3;
  EXPORT __ENH_Professional_License_2 := __EE5420548;
END;
