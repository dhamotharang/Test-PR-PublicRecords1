//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_Person_Event_3,B_Customer_Person_Event_6,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Person_Event_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_Person_Event_3.__ENH_Customer_Person_Event_3) __ENH_Customer_Person_Event_3 := B_Customer_Person_Event_3.__ENH_Customer_Person_Event_3;
  SHARED __EE38388 := __ENH_Customer_Person_Event_3;
  EXPORT __ENH_Customer_Person_Event_2 := __EE38388;
END;
