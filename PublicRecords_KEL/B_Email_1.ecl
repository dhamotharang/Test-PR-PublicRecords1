//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Email_2,CFG_Compile,E_Email FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Email_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_2(__in,__cfg).__ENH_Email_2) __ENH_Email_2 := B_Email_2(__in,__cfg).__ENH_Email_2;
  SHARED __EE4969276 := __ENH_Email_2;
  EXPORT __ENH_Email_1 := __EE4969276;
END;
