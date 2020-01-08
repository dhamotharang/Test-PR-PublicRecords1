//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Vehicle_4,CFG_Compile,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Vehicle_3(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Vehicle_4(__cfg).__ENH_Vehicle_4) __ENH_Vehicle_4 := B_Vehicle_4(__cfg).__ENH_Vehicle_4;
  SHARED __EE56694 := __ENH_Vehicle_4;
  EXPORT __ENH_Vehicle_3 := __EE56694;
END;
