//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Accident_3,B_Person_Accident_8,CFG_Compile,E_Accident,E_Person,E_Person_Accident FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Accident_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Accident_3(__in,__cfg).__ENH_Person_Accident_3) __ENH_Person_Accident_3 := B_Person_Accident_3(__in,__cfg).__ENH_Person_Accident_3;
  SHARED __EE7561838 := __ENH_Person_Accident_3;
  EXPORT __ENH_Person_Accident_2 := __EE7561838;
END;
