//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person_7,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_6 := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_7.__ENH_Person_7) __ENH_Person_7 := B_Person_7.__ENH_Person_7;
  SHARED __EE32879 := __ENH_Person_7;
  EXPORT __ENH_Person_6 := __EE32879;
END;
