﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Person_Event := MODULE
  SHARED TYPEOF(B_Event.__ENH_Event) __ENH_Event := B_Event.__ENH_Event;
  SHARED __EE2458584 := __ENH_Event;
  EXPORT Res0 := __UNWRAP(__EE2458584);
END;
