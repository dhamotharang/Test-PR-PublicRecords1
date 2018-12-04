//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_5,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Event_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_5.__ENH_Event_5) __ENH_Event_5 := B_Event_5.__ENH_Event_5;
  SHARED __EE28871 := __ENH_Event_5;
  EXPORT __ENH_Event_4 := __EE28871;
END;
