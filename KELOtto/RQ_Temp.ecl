﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ_Temp := MODULE
  SHARED __EE832609 := B_Event.IDX_Event_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE832609);
END;
