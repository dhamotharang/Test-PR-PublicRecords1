//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Person_Vehicle_1,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Person_Vehicle(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_1(__in,__cfg).__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1(__in,__cfg).__ENH_Person_Vehicle_1;
  SHARED __EE1415622 := __ENH_Person_Vehicle_1;
  EXPORT __ENH_Person_Vehicle := __EE1415622;
END;
