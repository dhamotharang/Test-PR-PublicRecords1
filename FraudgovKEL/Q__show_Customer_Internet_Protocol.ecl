﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Internet_Protocol,E_Customer,E_Internet_Protocol FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Internet_Protocol := MODULE
  SHARED TYPEOF(B_Internet_Protocol.__ENH_Internet_Protocol) __ENH_Internet_Protocol := B_Internet_Protocol.__ENH_Internet_Protocol;
  SHARED __EE4172780 := __ENH_Internet_Protocol;
  EXPORT Res0 := __UNWRAP(__EE4172780);
END;
