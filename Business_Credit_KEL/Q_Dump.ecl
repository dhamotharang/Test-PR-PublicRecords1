//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Business,B_Business_1,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT Q_Dump(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED TYPEOF(B_Business(__in,__cfg).__ENH_Business) __ENH_Business := B_Business(__in,__cfg).__ENH_Business;
  SHARED __EE11057485 := __ENH_Business;
  EXPORT Res0 := __UNWRAP(__EE11057485);
END;
