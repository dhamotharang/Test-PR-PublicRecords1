//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Inquiry_6,B_Inquiry_9,CFG_Compile,E_Inquiry FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Inquiry_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_6(__in,__cfg).__ENH_Inquiry_6) __ENH_Inquiry_6 := B_Inquiry_6(__in,__cfg).__ENH_Inquiry_6;
  SHARED __EE1643970 := __ENH_Inquiry_6;
  EXPORT __ENH_Inquiry_5 := __EE1643970;
END;
