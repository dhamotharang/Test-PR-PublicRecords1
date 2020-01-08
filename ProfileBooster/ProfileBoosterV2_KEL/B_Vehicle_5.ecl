//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Vehicle_6,B_Vehicle_7,CFG_Compile,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Vehicle_5(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Vehicle_6(__cfg).__ENH_Vehicle_6) __ENH_Vehicle_6 := B_Vehicle_6(__cfg).__ENH_Vehicle_6;
  SHARED __EE30070 := __ENH_Vehicle_6;
  EXPORT __ENH_Vehicle_5 := __EE30070;
END;
