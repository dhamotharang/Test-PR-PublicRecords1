//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Business,B_Business_1,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT Q_Dump(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED TYPEOF(B_Business(__in,__cfg).__ENH_Business) __ENH_Business := B_Business(__in,__cfg).__ENH_Business;
  SHARED __EE5602454 := __ENH_Business;
  EXPORT Res0 := __UNWRAP(__EE5602454);
END;
