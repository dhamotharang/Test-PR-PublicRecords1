//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License_3,B_Drivers_License_4,E_Customer,E_Drivers_License FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Drivers_License_3.__ENH_Drivers_License_3) __ENH_Drivers_License_3 := B_Drivers_License_3.__ENH_Drivers_License_3;
  SHARED __EE186238 := __ENH_Drivers_License_3;
  EXPORT __ENH_Drivers_License_2 := __EE186238;
END;
