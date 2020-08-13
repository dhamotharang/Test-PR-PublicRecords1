//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Email_1,B_Email_2,CFG_Compile,E_Email FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Email(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_1(__in,__cfg).__ENH_Email_1) __ENH_Email_1 := B_Email_1(__in,__cfg).__ENH_Email_1;
  SHARED __EE5641375 := __ENH_Email_1;
  EXPORT __ENH_Email := __EE5641375;
END;
