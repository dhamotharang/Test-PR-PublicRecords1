//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business_8,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Business_7(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_8(__in,__cfg).__ENH_Business_8) __ENH_Business_8 := B_Business_8(__in,__cfg).__ENH_Business_8;
  SHARED __EE284228 := __ENH_Business_8;
  EXPORT __ENH_Business_7 := __EE284228;
END;
