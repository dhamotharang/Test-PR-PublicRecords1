//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email,E_Customer,E_Email FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Email := MODULE
  SHARED __EE4671987 := B_Email.IDX_Email_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE4671987);
END;
