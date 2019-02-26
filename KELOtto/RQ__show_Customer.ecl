//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer := MODULE
  SHARED __EE721848 := B_Customer.IDX_Customer_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE721848);
END;
