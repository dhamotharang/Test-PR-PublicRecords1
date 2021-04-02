//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer,B_Customer_5,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer := MODULE
  SHARED TYPEOF(B_Customer.__ENH_Customer) __ENH_Customer := B_Customer.__ENH_Customer;
  SHARED __EE4591531 := __ENH_Customer;
  EXPORT Res0 := __UNWRAP(__EE4591531);
END;
