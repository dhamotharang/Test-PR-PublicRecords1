﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Bank,B_Bank_3,E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Bank := MODULE
  SHARED TYPEOF(B_Bank.__ENH_Bank) __ENH_Bank := B_Bank.__ENH_Bank;
  SHARED __EE609148 := __ENH_Bank;
  EXPORT Res0 := __UNWRAP(__EE609148);
END;
