//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_5,B_Customer_6 FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_5.__ENH_Customer_5) __ENH_Customer_5 := B_Customer_5.__ENH_Customer_5;
  SHARED __EE46547 := __ENH_Customer_5;
  EXPORT __ENH_Customer_4 := __EE46547;
END;
