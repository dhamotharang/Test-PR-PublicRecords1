//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Vehicle_7,CFG_Compile,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Vehicle_6(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Vehicle_7(__cfg).__ENH_Vehicle_7) __ENH_Vehicle_7 := B_Vehicle_7(__cfg).__ENH_Vehicle_7;
  SHARED __EE26518 := __ENH_Vehicle_7;
  EXPORT __ENH_Vehicle_6 := __EE26518;
END;
