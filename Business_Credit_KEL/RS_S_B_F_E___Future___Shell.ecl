//HPCC Systems KEL Compiler Version 0.8.2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL08a AS KEL;
IMPORT CFG_graph,RQ_S_B_F_E___Future___Shell FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
__RoxieQuery := RQ_S_B_F_E___Future___Shell;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
