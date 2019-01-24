//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person,B_Person_2,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Person := MODULE
  SHARED TYPEOF(B_Person.__ENH_Person) __ENH_Person := B_Person.__ENH_Person;
  SHARED __EE414647 := __ENH_Person;
  EXPORT Res0 := __UNWRAP(__EE414647);
END;
