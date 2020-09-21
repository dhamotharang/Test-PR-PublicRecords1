//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Tradeline,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT Q_Tradeline__dump(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED TYPEOF(B_Tradeline(__in,__cfg).__ENH_Tradeline) __ENH_Tradeline := B_Tradeline(__in,__cfg).__ENH_Tradeline;
  SHARED __EE10614256 := __ENH_Tradeline;
  EXPORT Res0 := __UNWRAP(__EE10614256);
END;
