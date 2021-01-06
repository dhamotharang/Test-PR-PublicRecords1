//HPCC Systems KEL Compiler Version 1.2.1-dev
#OPTION('expandSelectCreateRow',true);
IMPORT KEL12 AS KEL;
IMPORT CFG_graph,RQ_S_B_F_E___Shell FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
__RoxieQuery := RQ_S_B_F_E___Shell;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
