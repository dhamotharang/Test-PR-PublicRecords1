﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Email,E_Customer,E_Email FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Email := MODULE
  SHARED TYPEOF(B_Email.__ENH_Email) __ENH_Email := B_Email.__ENH_Email;
  SHARED __EE683330 := __ENH_Email;
  EXPORT Res0 := __UNWRAP(__EE683330);
END;
