//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Bank,E_Bank_Account,E_Customer,E_Person,E_Person_Bank_Account FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q_Temp := MODULE
  SHARED TYPEOF(E_Person_Bank_Account.__Result) __E_Person_Bank_Account := E_Person_Bank_Account.__Result;
  SHARED __EE414637 := __E_Person_Bank_Account;
  EXPORT Res0 := __UNWRAP(__EE414637);
END;
