//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Inquiry_9,CFG_Compile,E_Inquiry FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Inquiry_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_9(__in,__cfg).__ENH_Inquiry_9) __ENH_Inquiry_9 := B_Inquiry_9(__in,__cfg).__ENH_Inquiry_9;
  SHARED __EE1585045 := __ENH_Inquiry_9;
  EXPORT __ENH_Inquiry_8 := __EE1585045;
END;
