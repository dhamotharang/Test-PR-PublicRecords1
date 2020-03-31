//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Internet_Protocol_4,E_Customer,E_Internet_Protocol FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Internet_Protocol_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Internet_Protocol_4.__ENH_Internet_Protocol_4) __ENH_Internet_Protocol_4 := B_Internet_Protocol_4.__ENH_Internet_Protocol_4;
  SHARED __EE172274 := __ENH_Internet_Protocol_4;
  EXPORT __ENH_Internet_Protocol_3 := __EE172274;
END;
