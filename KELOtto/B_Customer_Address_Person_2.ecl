//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_Address_Person_3,E_Address,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Address_Person_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_Address_Person_3.__ENH_Customer_Address_Person_3) __ENH_Customer_Address_Person_3 := B_Customer_Address_Person_3.__ENH_Customer_Address_Person_3;
  SHARED __EE32496 := __ENH_Customer_Address_Person_3;
  EXPORT __ENH_Customer_Address_Person_2 := __EE32496;
END;
