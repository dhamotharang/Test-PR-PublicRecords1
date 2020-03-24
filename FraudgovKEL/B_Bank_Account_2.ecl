//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account_3,B_Bank_Account_4,E_Bank,E_Bank_Account,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_Account_3.__ENH_Bank_Account_3) __ENH_Bank_Account_3 := B_Bank_Account_3.__ENH_Bank_Account_3;
  SHARED __EE186197 := __ENH_Bank_Account_3;
  EXPORT __ENH_Bank_Account_2 := __EE186197;
END;
