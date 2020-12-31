//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Tradeline,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT Q_Tradeline__dump(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED TYPEOF(B_Tradeline(__in,__cfg).__ENH_Tradeline) __ENH_Tradeline := B_Tradeline(__in,__cfg).__ENH_Tradeline;
  SHARED __EE11048130 := __ENH_Tradeline;
  EXPORT Res0 := __UNWRAP(__EE11048130);
END;
