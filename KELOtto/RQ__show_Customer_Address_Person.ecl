//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person_Address,E_Address,E_Customer,E_Person,E_Person_Address FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Address_Person := MODULE
  SHARED __EE489960 := B_Person_Address.IDX_Person_Address_Location__Wrapped;
  EXPORT Res0 := __UNWRAP(__EE489960);
END;
