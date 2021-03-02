//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Person_Address,E_Address,E_Customer,E_Person,E_Person_Address FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Address_Person := MODULE
  SHARED TYPEOF(B_Person_Address.__ENH_Person_Address) __ENH_Person_Address := B_Person_Address.__ENH_Person_Address;
  SHARED __EE4591541 := __ENH_Person_Address;
  EXPORT Res0 := __UNWRAP(__EE4591541);
END;
