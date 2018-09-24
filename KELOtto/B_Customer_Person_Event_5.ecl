//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_Person_Event_6,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Person_Event_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_Person_Event_6.__ENH_Customer_Person_Event_6) __ENH_Customer_Person_Event_6 := B_Customer_Person_Event_6.__ENH_Customer_Person_Event_6;
  SHARED __EE21319 := __ENH_Customer_Person_Event_6;
  EXPORT __ENH_Customer_Person_Event_5 := __EE21319;
END;
