//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Person_Vehicle_4,B_Person_Vehicle_5,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Person_Vehicle_3(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_4(__cfg).__ENH_Person_Vehicle_4) __ENH_Person_Vehicle_4 := B_Person_Vehicle_4(__cfg).__ENH_Person_Vehicle_4;
  SHARED __EE56564 := __ENH_Person_Vehicle_4;
  EXPORT __ENH_Person_Vehicle_3 := __EE56564;
END;
