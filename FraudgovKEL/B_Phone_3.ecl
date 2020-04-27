//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Phone_4,E_Customer,E_Phone FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Phone_4.__ENH_Phone_4) __ENH_Phone_4 := B_Phone_4.__ENH_Phone_4;
  SHARED __EE205530 := __ENH_Phone_4;
  EXPORT __ENH_Phone_3 := __EE205530;
END;
