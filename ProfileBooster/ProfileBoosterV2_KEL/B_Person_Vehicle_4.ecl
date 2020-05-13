//HPCC Systems KEL Compiler Version 1.2.0beta4
IMPORT KEL12 AS KEL;
IMPORT B_Person_Vehicle_5,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_Vehicle_4(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_5(__cfg).__ENH_Person_Vehicle_5) __ENH_Person_Vehicle_5 := B_Person_Vehicle_5(__cfg).__ENH_Person_Vehicle_5;
  SHARED __EE36813 := __ENH_Person_Vehicle_5;
  EXPORT __ENH_Person_Vehicle_4 := __EE36813;
END;
