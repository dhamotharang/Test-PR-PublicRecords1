//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_6,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_6.__ENH_Customer_6) __ENH_Customer_6 := B_Customer_6.__ENH_Customer_6;
  SHARED __EE101511 := __ENH_Customer_6;
  EXPORT __ENH_Customer_5 := __EE101511;
END;
