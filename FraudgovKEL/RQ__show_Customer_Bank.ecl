//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank,B_Bank_2,E_Bank,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Bank := MODULE
  SHARED __EE4672007 := B_Bank.IDX_Bank_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE4672007);
END;
