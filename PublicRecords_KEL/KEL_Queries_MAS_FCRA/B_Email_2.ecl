//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Email_3,CFG_Compile,E_Email FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Email_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_3(__in,__cfg).__ENH_Email_3) __ENH_Email_3 := B_Email_3(__in,__cfg).__ENH_Email_3;
  SHARED __EE1264898 := __ENH_Email_3;
  EXPORT __ENH_Email_2 := __EE1264898;
END;
