﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ_Temp := MODULE
  SHARED __EE1362188 := B_Event.IDX_Event_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE1362188);
END;
