//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License_5,E_Customer,E_Drivers_License FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Drivers_License_5.__ENH_Drivers_License_5) __ENH_Drivers_License_5 := B_Drivers_License_5.__ENH_Drivers_License_5;
  SHARED __EE181665 := __ENH_Drivers_License_5;
  EXPORT __ENH_Drivers_License_4 := __EE181665;
END;
