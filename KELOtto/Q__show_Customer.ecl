﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer := MODULE
  SHARED TYPEOF(B_Customer.__ENH_Customer) __ENH_Customer := B_Customer.__ENH_Customer;
  SHARED __EE150983 := __ENH_Customer;
  EXPORT Res0 := __UNWRAP(__EE150983);
END;
