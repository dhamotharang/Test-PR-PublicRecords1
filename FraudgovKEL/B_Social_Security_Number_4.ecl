//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Social_Security_Number_5,E_Customer,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Social_Security_Number_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Social_Security_Number_5.__ENH_Social_Security_Number_5) __ENH_Social_Security_Number_5 := B_Social_Security_Number_5.__ENH_Social_Security_Number_5;
  SHARED __EE335781 := __ENH_Social_Security_Number_5;
  EXPORT __ENH_Social_Security_Number_4 := __EE335781;
END;
