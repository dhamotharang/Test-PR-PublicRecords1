﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_2,B_Bank_3,E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_2.__ENH_Bank_2) __ENH_Bank_2 := B_Bank_2.__ENH_Bank_2;
  SHARED __EE510449 := __ENH_Bank_2;
  EXPORT __ENH_Bank_1 := __EE510449;
END;
