﻿//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT B_Education_4,B_Education_7,CFG_Compile,E_Education FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Education_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Education_4(__in,__cfg).__ENH_Education_4) __ENH_Education_4 := B_Education_4(__in,__cfg).__ENH_Education_4;
  SHARED __EE3956437 := __ENH_Education_4;
  EXPORT __ENH_Education_3 := __EE3956437;
END;
