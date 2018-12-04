//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Bank,E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Bank := MODULE
  SHARED __EE503085 := B_Bank.IDX_Bank_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE503085);
END;
