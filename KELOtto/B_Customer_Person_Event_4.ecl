//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_Person_Event_5,B_Customer_Person_Event_6,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Person_Event_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_Person_Event_5.__ENH_Customer_Person_Event_5) __ENH_Customer_Person_Event_5 := B_Customer_Person_Event_5.__ENH_Customer_Person_Event_5;
  SHARED __EE21554 := __ENH_Customer_Person_Event_5;
  EXPORT __ENH_Customer_Person_Event_4 := __EE21554;
END;
