//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Phone,E_Customer,E_Phone FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Phone := MODULE
  SHARED __EE4671997 := B_Phone.IDX_Phone_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE4671997);
END;
