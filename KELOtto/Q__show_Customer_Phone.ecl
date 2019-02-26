//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Phone,E_Customer,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Phone := MODULE
  SHARED TYPEOF(B_Phone.__ENH_Phone) __ENH_Phone := B_Phone.__ENH_Phone;
  SHARED __EE595634 := __ENH_Phone;
  EXPORT Res0 := __UNWRAP(__EE595634);
END;
