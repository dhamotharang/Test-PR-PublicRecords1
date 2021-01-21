//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email_5,E_Customer,E_Email FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_5.__ENH_Email_5) __ENH_Email_5 := B_Email_5.__ENH_Email_5;
  SHARED __EE192369 := __ENH_Email_5;
  EXPORT __ENH_Email_4 := __EE192369;
END;
