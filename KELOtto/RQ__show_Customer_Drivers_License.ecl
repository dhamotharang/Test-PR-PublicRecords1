//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License,E_Customer,E_Drivers_License FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Drivers_License := MODULE
  SHARED __EE527235 := B_Drivers_License.IDX_Drivers_License_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE527235);
END;
