﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Email_2,B_Email_3,CFG_Compile,E_Email FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Email_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_2(__in,__cfg).__ENH_Email_2) __ENH_Email_2 := B_Email_2(__in,__cfg).__ENH_Email_2;
  SHARED __EE5493142 := __ENH_Email_2;
  EXPORT __ENH_Email_1 := __EE5493142;
END;
