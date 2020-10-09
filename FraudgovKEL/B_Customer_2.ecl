//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_3,B_Customer_4,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_3.__ENH_Customer_3) __ENH_Customer_3 := B_Customer_3.__ENH_Customer_3;
  SHARED __EE683416 := __ENH_Customer_3;
  EXPORT __ENH_Customer_2 := __EE683416;
END;
