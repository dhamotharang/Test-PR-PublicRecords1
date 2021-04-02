//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Phone_5,E_Customer,E_Phone FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Phone_5.__ENH_Phone_5) __ENH_Phone_5 := B_Phone_5.__ENH_Phone_5;
  SHARED __EE314330 := __ENH_Phone_5;
  EXPORT __ENH_Phone_4 := __EE314330;
END;
