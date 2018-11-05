//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_Licence,E_Customer,E_Drivers_Licence FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Drivers_Licence := MODULE
  SHARED TYPEOF(B_Drivers_Licence.__ENH_Drivers_Licence) __ENH_Drivers_Licence := B_Drivers_Licence.__ENH_Drivers_Licence;
  SHARED __EE381725 := __ENH_Drivers_Licence;
  EXPORT Res0 := __UNWRAP(__EE381725);
END;
