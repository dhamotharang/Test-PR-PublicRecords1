//HPCC Systems KEL Compiler Version 0.11.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL011 AS KEL;
IMPORT RQ_Temp FROM KELOtto;
IMPORT * FROM KEL011.Null;
__RoxieQuery := RQ_Temp;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
