//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Industry_5,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT B_Industry_4(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Industry_5(__in,__cfg).__ENH_Industry_5) __ENH_Industry_5 := B_Industry_5(__in,__cfg).__ENH_Industry_5;
  SHARED __EE241816 := __ENH_Industry_5;
  EXPORT __ENH_Industry_4 := __EE241816;
END;
