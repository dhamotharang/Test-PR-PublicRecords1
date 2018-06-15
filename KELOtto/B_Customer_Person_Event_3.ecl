//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_Person_Event_4,B_Customer_Person_Event_6,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Person_Event_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_Person_Event_4.__ENH_Customer_Person_Event_4) __ENH_Customer_Person_Event_4 := B_Customer_Person_Event_4.__ENH_Customer_Person_Event_4;
  SHARED __EE27577 := __ENH_Customer_Person_Event_4;
  EXPORT __ENH_Customer_Person_Event_3 := __EE27577;
END;
