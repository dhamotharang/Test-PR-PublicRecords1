//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email_4,E_Customer,E_Email FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_4.__ENH_Email_4) __ENH_Email_4 := B_Email_4.__ENH_Email_4;
  SHARED __EE156078 := __ENH_Email_4;
  EXPORT __ENH_Email_3 := __EE156078;
END;
