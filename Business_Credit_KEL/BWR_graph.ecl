//HPCC Systems KEL Compiler Version 1.2.1-dev
#OPTION('expandSelectCreateRow',true);
IMPORT KEL12 AS KEL;
IMPORT CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
IMPORT * FROM Business_Credit_KEL;
OUTPUT(Q_Tradeline__dump().Res0,NAMED('Tradeline_dump_0'));
OUTPUT(Q_S_B_F_E___Future___Shell().Res0,NAMED('SBFE_Future_Shell_0'));
OUTPUT(Q_S_B_F_E___Shell().Res0,NAMED('SBFE_Shell_0'));
OUTPUT(Q_Dump().Res0,NAMED('Dump_0'));

