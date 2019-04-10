//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Internet_Protocol,E_Customer,E_Internet_Protocol FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Internet_Protocol := MODULE
  SHARED __EE827655 := B_Internet_Protocol.IDX_Internet_Protocol_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE827655);
END;
