﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Professional_License_1,B_Professional_License_4,CFG_Compile,E_Professional_License FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Professional_License(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Professional_License_1(__cfg).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1(__cfg).__ENH_Professional_License_1;
  SHARED __EE11507423 := __ENH_Professional_License_1;
  EXPORT __ENH_Professional_License := __EE11507423;
END;
