//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,B_Customer_6 FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED __EE61616 := __ENH_Customer_4;
  EXPORT __ENH_Customer_3 := __EE61616;
END;
