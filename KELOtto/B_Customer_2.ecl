//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_3,B_Customer_6 FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_3.__ENH_Customer_3) __ENH_Customer_3 := B_Customer_3.__ENH_Customer_3;
  SHARED __EE103558 := __ENH_Customer_3;
  EXPORT __ENH_Customer_2 := __EE103558;
END;
