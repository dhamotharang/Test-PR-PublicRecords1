﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_3,E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_3.__ENH_Bank_3) __ENH_Bank_3 := B_Bank_3.__ENH_Bank_3;
  SHARED __EE234898 := __ENH_Bank_3;
  EXPORT __ENH_Bank_2 := __EE234898;
END;
