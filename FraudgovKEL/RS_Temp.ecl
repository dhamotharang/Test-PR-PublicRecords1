//HPCC Systems KEL Compiler Version 0.11.6-2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL011 AS KEL;
IMPORT RQ_Temp FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
__RoxieQuery := RQ_Temp;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
