//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Address,E_Address,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Address := MODULE
  SHARED TYPEOF(B_Address.__ENH_Address) __ENH_Address := B_Address.__ENH_Address;
  SHARED __EE4549225 := __ENH_Address;
  EXPORT Res0 := __UNWRAP(__EE4549225);
END;
