//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Person,B_Person_1,E_Address,E_Customer,E_Person FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Person := MODULE
  SHARED __EE4714279 := B_Person.IDX_Person_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE4714279);
END;
