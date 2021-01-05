//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business,B_Business_1,CFG_graph,E_Business FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT RQ_Dump := MODULE
  SHARED __EE10646105 := B_Business().IDX_Business_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE10646105);
END;
