﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank,B_Bank_2,E_Bank,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Bank := MODULE
  SHARED TYPEOF(B_Bank.__ENH_Bank) __ENH_Bank := B_Bank.__ENH_Bank;
  SHARED __EE1179100 := __ENH_Bank;
  EXPORT Res0 := __UNWRAP(__EE1179100);
END;
