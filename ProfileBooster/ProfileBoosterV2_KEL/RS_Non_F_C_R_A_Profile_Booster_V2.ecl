//HPCC Systems KEL Compiler Version 1.1.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,RQ_Non_F_C_R_A_Profile_Booster_V2 FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL11.Null;
SET OF KEL.typ.int __PLexIDs_in := [] : STORED('LexIDs_in');
KEL.typ.kdate __PInputArchiveDateClean := 0 : STORED('InputArchiveDateClean');
UNSIGNED8 __PDPM := 0 : STORED('DPM');
__RoxieQuery := RQ_Non_F_C_R_A_Profile_Booster_V2(DATASET([{1,__PLexIDs_in,__PInputArchiveDateClean,__PDPM}],CFG_Compile.Non_F_C_R_A_Profile_Booster_V2_Params_Layout));
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
