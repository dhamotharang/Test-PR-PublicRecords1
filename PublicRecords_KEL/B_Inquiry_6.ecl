﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Inquiry_7,B_Inquiry_9,CFG_Compile,E_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Inquiry_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_7(__in,__cfg).__ENH_Inquiry_7) __ENH_Inquiry_7 := B_Inquiry_7(__in,__cfg).__ENH_Inquiry_7;
  SHARED __EE4850563 := __ENH_Inquiry_7;
  EXPORT __ENH_Inquiry_6 := __EE4850563;
END;
