//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Industry_3,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Industry_2(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Industry_3(__in,__cfg).__ENH_Industry_3) __ENH_Industry_3 := B_Industry_3(__in,__cfg).__ENH_Industry_3;
  SHARED __EE9980798 := __ENH_Industry_3;
  EXPORT __ENH_Industry_2 := __EE9980798;
END;
