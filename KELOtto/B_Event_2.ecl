//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_3,B_Event_5,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Event_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_3.__ENH_Event_3) __ENH_Event_3 := B_Event_3.__ENH_Event_3;
  SHARED __EE47994 := __ENH_Event_3;
  EXPORT __ENH_Event_2 := __EE47994;
END;
