//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_Accident_7,B_Person_Accident_8,CFG_Compile,E_Accident,E_Person,E_Person_Accident FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Accident_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Accident_7(__in,__cfg).__ENH_Person_Accident_7) __ENH_Person_Accident_7 := B_Person_Accident_7(__in,__cfg).__ENH_Person_Accident_7;
  SHARED __EE1632572 := __ENH_Person_Accident_7;
  EXPORT __ENH_Person_Accident_6 := __EE1632572;
END;
