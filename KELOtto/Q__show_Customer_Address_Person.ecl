//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Person,E_Person_Address FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Address_Person := MODULE
  SHARED TYPEOF(E_Person_Address.__Result) __E_Person_Address := E_Person_Address.__Result;
  SHARED __EE685044 := __E_Person_Address;
  EXPORT Res0 := __UNWRAP(__EE685044);
END;
