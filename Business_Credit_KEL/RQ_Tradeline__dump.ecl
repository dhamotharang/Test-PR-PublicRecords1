//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Tradeline,CFG_graph,E_Tradeline FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT RQ_Tradeline__dump := MODULE
  SHARED __EE5607739 := B_Tradeline().IDX_Tradeline_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE5607739);
END;
