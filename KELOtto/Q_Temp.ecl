//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q_Temp := MODULE
  SHARED TYPEOF(B_Event.__ENH_Event) __ENH_Event := B_Event.__ENH_Event;
  SHARED __EE609099 := __ENH_Event;
  EXPORT Res0 := __UNWRAP(__EE609099);
END;
