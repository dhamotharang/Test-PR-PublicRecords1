//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account,E_Bank,E_Bank_Account,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Bank_Account := MODULE
  SHARED __EE452446 := B_Bank_Account.IDX_Bank_Account_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE452446);
END;
