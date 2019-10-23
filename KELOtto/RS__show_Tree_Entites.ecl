//HPCC Systems KEL Compiler Version 0.11.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL011 AS KEL;
IMPORT RQ__show_Tree_Entites FROM KELOtto;
IMPORT * FROM KEL011.Null;
__RoxieQuery := RQ__show_Tree_Entites;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
