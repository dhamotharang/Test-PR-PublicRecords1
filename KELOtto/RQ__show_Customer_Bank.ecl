﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Bank,B_Bank_3,E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Bank := MODULE
  SHARED __EE832647 := B_Bank.IDX_Bank_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE832647);
END;
