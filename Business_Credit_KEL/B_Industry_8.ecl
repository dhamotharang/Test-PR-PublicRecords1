//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Industry_9,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT B_Industry_8(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Industry_9(__in,__cfg).__ENH_Industry_9) __ENH_Industry_9 := B_Industry_9(__in,__cfg).__ENH_Industry_9;
  SHARED __EE156697 := __ENH_Industry_9;
  EXPORT __ENH_Industry_8 := __EE156697;
END;
