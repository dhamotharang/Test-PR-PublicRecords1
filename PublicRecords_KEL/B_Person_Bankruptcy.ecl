//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Person_Bankruptcy_1,CFG_Compile,E_Bankruptcy,E_Person,E_Person_Bankruptcy FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Person_Bankruptcy(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Bankruptcy_1(__in,__cfg).__ENH_Person_Bankruptcy_1) __ENH_Person_Bankruptcy_1 := B_Person_Bankruptcy_1(__in,__cfg).__ENH_Person_Bankruptcy_1;
  SHARED __EE1415362 := __ENH_Person_Bankruptcy_1;
  EXPORT __ENH_Person_Bankruptcy := __EE1415362;
END;
