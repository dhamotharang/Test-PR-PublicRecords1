//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License,E_Customer,E_Drivers_License FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Drivers_License := MODULE
  SHARED TYPEOF(B_Drivers_License.__ENH_Drivers_License) __ENH_Drivers_License := B_Drivers_License.__ENH_Drivers_License;
  SHARED __EE393910 := __ENH_Drivers_License;
  EXPORT Res0 := __UNWRAP(__EE393910);
END;
