//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Business_8,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT B_Business_7(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_8(__in,__cfg).__ENH_Business_8) __ENH_Business_8 := B_Business_8(__in,__cfg).__ENH_Business_8;
  SHARED __EE164170 := __ENH_Business_8;
  EXPORT __ENH_Business_7 := __EE164170;
END;
