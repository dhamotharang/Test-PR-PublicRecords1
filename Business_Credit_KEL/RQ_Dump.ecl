//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Business,B_Business_1,CFG_graph,E_Business FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT RQ_Dump := MODULE
  SHARED __EE9965730 := B_Business().IDX_Business_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE9965730);
END;
