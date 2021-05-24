//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Professional_License_4,CFG_Compile,E_Professional_License FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Professional_License_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4;
  SHARED __EE2002636 := __ENH_Professional_License_4;
  EXPORT __ENH_Professional_License_3 := __EE2002636;
END;
