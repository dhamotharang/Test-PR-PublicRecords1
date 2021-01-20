//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Industry_7,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Industry_6(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Industry_7(__in,__cfg).__ENH_Industry_7) __ENH_Industry_7 := B_Industry_7(__in,__cfg).__ENH_Industry_7;
  SHARED __EE9815883 := __ENH_Industry_7;
  EXPORT __ENH_Industry_6 := __EE9815883;
END;
