﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Social_Security_Number,E_Customer,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Social_Security_Number := MODULE
  SHARED __EE2807260 := B_Social_Security_Number.IDX_Social_Security_Number_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE2807260);
END;
