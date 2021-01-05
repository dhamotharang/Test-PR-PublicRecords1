//HPCC Systems KEL Compiler Version 1.2.1-dev
#OPTION('expandSelectCreateRow',true);
IMPORT KEL12 AS KEL;
IMPORT CFG_graph,RQ_Tradeline__dump FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
__RoxieQuery := RQ_Tradeline__dump;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
