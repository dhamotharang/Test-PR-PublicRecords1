//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Individual_Owner_2,B_Individual_Owner_3,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Individual_Owner_1(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Individual_Owner_2(__in,__cfg).__ENH_Individual_Owner_2) __ENH_Individual_Owner_2 := B_Individual_Owner_2(__in,__cfg).__ENH_Individual_Owner_2;
  SHARED __EE12136983 := __ENH_Individual_Owner_2;
  EXPORT __ENH_Individual_Owner_1 := __EE12136983;
END;
