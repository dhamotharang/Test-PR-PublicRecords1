//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Industry_7,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Industry_6(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Industry_7(__in,__cfg).__ENH_Industry_7) __ENH_Industry_7 := B_Industry_7(__in,__cfg).__ENH_Industry_7;
  SHARED __EE318475 := __ENH_Industry_7;
  EXPORT __ENH_Industry_6 := __EE318475;
END;
