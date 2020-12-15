//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Address,E_Address,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Address := MODULE
  SHARED __EE4671977 := B_Address.IDX_Address_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE4671977);
END;
