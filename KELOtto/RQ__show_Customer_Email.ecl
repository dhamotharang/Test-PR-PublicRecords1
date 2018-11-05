//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Email,E_Customer,E_Email FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Email := MODULE
  SHARED __EE489965 := B_Email.IDX_Email_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE489965);
END;
