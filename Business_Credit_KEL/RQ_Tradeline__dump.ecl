//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Tradeline,CFG_graph,E_Tradeline FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT RQ_Tradeline__dump := MODULE
  SHARED __EE9779327 := B_Tradeline().IDX_Tradeline_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE9779327);
END;
