//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Business_6,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Business_5(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_6(__in,__cfg).__ENH_Business_6) __ENH_Business_6 := B_Business_6(__in,__cfg).__ENH_Business_6;
  SHARED __EE9994540 := __ENH_Business_6;
  EXPORT __ENH_Business_5 := __EE9994540;
END;
