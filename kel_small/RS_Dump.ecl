//HPCC Systems KEL Compiler Version 0.10.0rc2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL010 AS KEL;
IMPORT RQ_Dump FROM KEL_Small;
IMPORT * FROM KEL010.Null;
__RoxieQuery := RQ_Dump;
OUTPUT(__RoxieQuery.Res0,NAMED('Result0'));
OUTPUT(__RoxieQuery.Res1,NAMED('Result1'));
OUTPUT(__RoxieQuery.Res2,NAMED('Result2'));
