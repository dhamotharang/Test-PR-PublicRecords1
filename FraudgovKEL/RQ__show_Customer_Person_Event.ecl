//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event,B_Event_1,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Person_Event := MODULE
  SHARED __EE4714274 := B_Event.IDX_Event_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE4714274);
END;
