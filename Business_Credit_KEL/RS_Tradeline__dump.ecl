//HPCC Systems KEL Compiler Version 0.8.2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL08a AS KEL;
IMPORT CFG_graph,RQ_Tradeline__dump FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
__RoxieQuery := RQ_Tradeline__dump;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
