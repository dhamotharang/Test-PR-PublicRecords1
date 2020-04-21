//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account_4,E_Bank,E_Bank_Account,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_Account_4.__ENH_Bank_Account_4) __ENH_Bank_Account_4 := B_Bank_Account_4.__ENH_Bank_Account_4;
  SHARED __EE166685 := __ENH_Bank_Account_4;
  EXPORT __ENH_Bank_Account_3 := __EE166685;
END;
