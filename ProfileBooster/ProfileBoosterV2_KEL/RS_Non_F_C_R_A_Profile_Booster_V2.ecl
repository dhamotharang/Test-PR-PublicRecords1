//HPCC Systems KEL Compiler Version 1.2.1-dev
#OPTION('expandSelectCreateRow',true);
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,RQ_Non_F_C_R_A_Profile_Booster_V2 FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
KEL.typ.uid __PLexID_in := 0 : STORED('LexID_in');
KEL.typ.kdate __PP_InpClnArchDt := 0 : STORED('P_InpClnArchDt');
UNSIGNED8 __PDPM := 0 : STORED('DPM');
__RoxieQuery := RQ_Non_F_C_R_A_Profile_Booster_V2(DATASET([{1,__PLexID_in,__PP_InpClnArchDt,__PDPM}],CFG_Compile.Non_F_C_R_A_Profile_Booster_V2_Params_Layout));
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
