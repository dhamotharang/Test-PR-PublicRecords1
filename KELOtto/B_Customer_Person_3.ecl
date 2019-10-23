//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_Person_4,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Person_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_Person_4.__ENH_Customer_Person_4) __ENH_Customer_Person_4 := B_Customer_Person_4.__ENH_Customer_Person_4;
  SHARED __EE27560 := __ENH_Customer_Person_4;
  EXPORT __ENH_Customer_Person_3 := __EE27560;
END;
