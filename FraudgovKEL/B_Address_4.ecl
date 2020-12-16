//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Address_5,E_Address,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Address_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_5.__ENH_Address_5) __ENH_Address_5 := B_Address_5.__ENH_Address_5;
  SHARED __EE192161 := __ENH_Address_5;
  EXPORT __ENH_Address_4 := __EE192161;
END;
