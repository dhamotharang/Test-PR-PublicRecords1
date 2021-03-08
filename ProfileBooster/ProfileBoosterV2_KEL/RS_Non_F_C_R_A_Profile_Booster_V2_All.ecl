//HPCC Systems KEL Compiler Version 1.2.1-dev
#OPTION('expandSelectCreateRow',true);
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,RQ_Non_F_C_R_A_Profile_Booster_V2_All FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
KEL.typ.kdate __PInputArchiveDateClean := 0 : STORED('InputArchiveDateClean');
UNSIGNED8 __PDPM := 0 : STORED('DPM');
__RoxieQuery := RQ_Non_F_C_R_A_Profile_Booster_V2_All(DATASET([{1,__PInputArchiveDateClean,__PDPM}],CFG_Compile.Non_F_C_R_A_Profile_Booster_V2_All_Params_Layout));
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
