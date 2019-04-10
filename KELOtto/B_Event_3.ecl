//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_4,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Event_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED __EE61792 := __ENH_Event_4;
  EXPORT __ENH_Event_3 := __EE61792;
END;
