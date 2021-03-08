//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Vehicle_4,CFG_Compile,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Vehicle_3(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Vehicle_4(__cfg).__ENH_Vehicle_4) __ENH_Vehicle_4 := B_Vehicle_4(__cfg).__ENH_Vehicle_4;
  SHARED __EE56835 := __ENH_Vehicle_4;
  EXPORT __ENH_Vehicle_3 := __EE56835;
END;
