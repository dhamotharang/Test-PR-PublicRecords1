//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account,E_Bank,E_Bank_Account,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Bank_Account := MODULE
  SHARED TYPEOF(B_Bank_Account.__ENH_Bank_Account) __ENH_Bank_Account := B_Bank_Account.__ENH_Bank_Account;
  SHARED __EE683355 := __ENH_Bank_Account;
  EXPORT Res0 := __UNWRAP(__EE683355);
END;
