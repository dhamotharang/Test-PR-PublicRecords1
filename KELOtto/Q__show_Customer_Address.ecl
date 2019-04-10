//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Address,E_Address,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Address := MODULE
  SHARED TYPEOF(B_Address.__ENH_Address) __ENH_Address := B_Address.__ENH_Address;
  SHARED __EE685040 := __ENH_Address;
  EXPORT Res0 := __UNWRAP(__EE685040);
END;
