//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Accident_8,CFG_Compile,E_Accident,E_Person,E_Person_Accident FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Accident_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Accident_8(__in,__cfg).__ENH_Person_Accident_8) __ENH_Person_Accident_8 := B_Person_Accident_8(__in,__cfg).__ENH_Person_Accident_8;
  SHARED __EE5091044 := __ENH_Person_Accident_8;
  EXPORT __ENH_Person_Accident_7 := __EE5091044;
END;
