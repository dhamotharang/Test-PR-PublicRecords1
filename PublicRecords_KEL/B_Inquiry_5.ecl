//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Inquiry_6,B_Inquiry_9,CFG_Compile,E_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Inquiry_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_6(__in,__cfg).__ENH_Inquiry_6) __ENH_Inquiry_6 := B_Inquiry_6(__in,__cfg).__ENH_Inquiry_6;
  SHARED __EE4925207 := __ENH_Inquiry_6;
  EXPORT __ENH_Inquiry_5 := __EE4925207;
END;
