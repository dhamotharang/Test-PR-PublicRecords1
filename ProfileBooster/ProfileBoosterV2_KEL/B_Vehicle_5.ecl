//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Vehicle_6,B_Vehicle_7,CFG_Compile,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Vehicle_5(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Vehicle_6(__cfg).__ENH_Vehicle_6) __ENH_Vehicle_6 := B_Vehicle_6(__cfg).__ENH_Vehicle_6;
  SHARED __EE30913 := __ENH_Vehicle_6;
  EXPORT __ENH_Vehicle_5 := __EE30913;
END;
