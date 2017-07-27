//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Business,B_Business_1,CFG_graph,E_Business FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT RQ_Dump := MODULE
  SHARED __EE5633888 := B_Business().IDX_Business_UID_Wrapped;
  EXPORT Res0 := __UNWRAP(__EE5633888);
END;
