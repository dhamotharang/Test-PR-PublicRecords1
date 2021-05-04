//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account,E_Bank,E_Bank_Account,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Bank_Account := MODULE
  SHARED __EE4714324 := B_Bank_Account.IDX_Bank_Account_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE4714324);
END;
