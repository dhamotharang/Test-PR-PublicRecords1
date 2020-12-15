//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Internet_Protocol_5,E_Customer,E_Internet_Protocol FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Internet_Protocol_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Internet_Protocol_5.__ENH_Internet_Protocol_5) __ENH_Internet_Protocol_5 := B_Internet_Protocol_5.__ENH_Internet_Protocol_5;
  SHARED __EE301003 := __ENH_Internet_Protocol_5;
  EXPORT __ENH_Internet_Protocol_4 := __EE301003;
END;
