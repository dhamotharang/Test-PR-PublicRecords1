//HPCC Systems KEL Compiler Version 1.2.1-dev
#OPTION('expandSelectCreateRow',true);
IMPORT KEL12 AS KEL;
IMPORT B_BuildAll_Graph,CFG_Graph FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
B_BuildAll_Graph.BuildAll;
