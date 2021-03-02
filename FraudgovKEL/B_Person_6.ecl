//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Person_7,E_Address,E_Customer,E_Person FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_6 := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_7.__ENH_Person_7) __ENH_Person_7 := B_Person_7.__ENH_Person_7;
  SHARED __EE138104 := __ENH_Person_7;
  EXPORT __ENH_Person_6 := __EE138104;
END;
