//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Bank := MODULE
  SHARED TYPEOF(E_Bank.__Result) __E_Bank := E_Bank.__Result;
  SHARED __EE381715 := __E_Bank;
  EXPORT Res0 := __UNWRAP(__EE381715);
END;
