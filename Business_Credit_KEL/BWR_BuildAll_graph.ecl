//HPCC Systems KEL Compiler Version 1.3.2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL13 AS KEL;
IMPORT B_BuildAll_graph,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
B_BuildAll_graph().BuildAll;
