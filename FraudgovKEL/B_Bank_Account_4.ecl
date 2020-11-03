//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account_5,E_Bank,E_Bank_Account,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_Account_5.__ENH_Bank_Account_5) __ENH_Bank_Account_5 := B_Bank_Account_5.__ENH_Bank_Account_5;
  SHARED __EE192178 := __ENH_Bank_Account_5;
  EXPORT __ENH_Bank_Account_4 := __EE192178;
END;
