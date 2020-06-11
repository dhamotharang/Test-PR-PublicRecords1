//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer,B_Customer_4,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer := MODULE
  SHARED __EE3429987 := B_Customer.IDX_Customer_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE3429987);
END;
