//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Tradeline,CFG_graph,E_Tradeline FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT RQ_Tradeline__dump := MODULE
  SHARED __EE10636750 := B_Tradeline().IDX_Tradeline_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE10636750);
END;
