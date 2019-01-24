//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Address,E_Address,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Address := MODULE
  SHARED __EE527195 := B_Address.IDX_Address_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE527195);
END;
