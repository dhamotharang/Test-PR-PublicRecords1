//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Social_Security_Number,E_Customer,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Social_Security_Number := MODULE
  SHARED __EE505330 := B_Social_Security_Number.IDX_Social_Security_Number_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE505330);
END;
