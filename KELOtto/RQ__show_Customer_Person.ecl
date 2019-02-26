//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person,B_Person_2,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Person := MODULE
  SHARED __EE721843 := B_Person.IDX_Person_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE721843);
END;
