﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Social_Security_Number,E_Customer,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Social_Security_Number := MODULE
  SHARED TYPEOF(B_Social_Security_Number.__ENH_Social_Security_Number) __ENH_Social_Security_Number := B_Social_Security_Number.__ENH_Social_Security_Number;
  SHARED __EE1165279 := __ENH_Social_Security_Number;
  EXPORT Res0 := __UNWRAP(__EE1165279);
END;
