//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Internet_Protocol_3,B_Internet_Protocol_4,E_Customer,E_Internet_Protocol FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Internet_Protocol_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Internet_Protocol_3.__ENH_Internet_Protocol_3) __ENH_Internet_Protocol_3 := B_Internet_Protocol_3.__ENH_Internet_Protocol_3;
  SHARED __EE194175 := __ENH_Internet_Protocol_3;
  EXPORT __ENH_Internet_Protocol_2 := __EE194175;
END;
