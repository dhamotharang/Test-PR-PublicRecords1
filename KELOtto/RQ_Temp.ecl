//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person_Bank_Account,E_Bank,E_Bank_Account,E_Customer,E_Person,E_Person_Bank_Account FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ_Temp := MODULE
  SHARED __EE489935 := B_Person_Bank_Account.IDX_Person_Bank_Account_Account__Wrapped;
  EXPORT Res0 := __UNWRAP(__EE489935);
END;
