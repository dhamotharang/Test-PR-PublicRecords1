//HPCC Systems KEL Compiler Version 1.1.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL11 AS KEL;
IMPORT B_BuildAll_Graph,CFG_Graph FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL11.Null;
B_BuildAll_Graph.BuildAll;
