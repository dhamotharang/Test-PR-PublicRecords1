//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Professional_License_3,B_Professional_License_4,CFG_Compile,E_Professional_License FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Professional_License_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3;
  SHARED __EE4608529 := __ENH_Professional_License_3;
  EXPORT __ENH_Professional_License_2 := __EE4608529;
END;
