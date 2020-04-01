//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License_4,E_Customer,E_Drivers_License FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Drivers_License_4.__ENH_Drivers_License_4) __ENH_Drivers_License_4 := B_Drivers_License_4.__ENH_Drivers_License_4;
  SHARED __EE156140 := __ENH_Drivers_License_4;
  EXPORT __ENH_Drivers_License_3 := __EE156140;
END;
