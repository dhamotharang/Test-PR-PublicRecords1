//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_Licence,E_Customer,E_Drivers_Licence FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Drivers_Licence := MODULE
  SHARED __EE452451 := B_Drivers_Licence.IDX_Drivers_Licence_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE452451);
END;
