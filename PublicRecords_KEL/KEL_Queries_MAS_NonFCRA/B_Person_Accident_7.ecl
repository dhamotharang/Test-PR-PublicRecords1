//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_Accident_8,CFG_Compile,E_Accident,E_Person,E_Person_Accident FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Accident_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Accident_8(__in,__cfg).__ENH_Person_Accident_8) __ENH_Person_Accident_8 := B_Person_Accident_8(__in,__cfg).__ENH_Person_Accident_8;
  SHARED __EE1594885 := __ENH_Person_Accident_8;
  EXPORT __ENH_Person_Accident_7 := __EE1594885;
END;
