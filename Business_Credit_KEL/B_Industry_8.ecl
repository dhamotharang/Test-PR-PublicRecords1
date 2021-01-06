//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Industry_9,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Industry_8(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Industry_9(__in,__cfg).__ENH_Industry_9) __ENH_Industry_9 := B_Industry_9(__in,__cfg).__ENH_Industry_9;
  SHARED __EE291798 := __ENH_Industry_9;
  EXPORT __ENH_Industry_8 := __EE291798;
END;
