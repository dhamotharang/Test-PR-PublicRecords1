//HPCC Systems KEL Compiler Version 1.3.2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL13 AS KEL;
IMPORT CFG_graph,RQ_S_B_F_E___Future___Shell FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
__RoxieQuery := RQ_S_B_F_E___Future___Shell;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
