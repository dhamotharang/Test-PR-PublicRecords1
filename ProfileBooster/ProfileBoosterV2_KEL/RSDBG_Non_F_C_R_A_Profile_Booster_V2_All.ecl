﻿//HPCC Systems KEL Compiler Version 1.1.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,RQ_Non_F_C_R_A_Profile_Booster_V2_All FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL11.Null;
KEL.typ.kdate __PInputArchiveDateClean := 0 : STORED('InputArchiveDateClean');
UNSIGNED8 __PDPM := 0 : STORED('DPM');
__RoxieQuery := RQ_Non_F_C_R_A_Profile_Booster_V2_All(DATASET([{1,__PInputArchiveDateClean,__PDPM}],CFG_Compile.Non_F_C_R_A_Profile_Booster_V2_All_Params_Layout));
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
OUTPUT(__RoxieQuery.DBG_Params,NAMED('DBG_Params'));
OUTPUT(__RoxieQuery.DBG_E_Person_PreEntity,NAMED('DBG_E_Person_PreEntity'));
OUTPUT(__RoxieQuery.DBG_E_Person_FilteredPreEntity,NAMED('DBG_E_Person_FilteredPreEntity'));
OUTPUT(__RoxieQuery.DBG_E_Person_Result,NAMED('DBG_E_Person_Result'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_PreEntity,NAMED('DBG_E_Person_Vehicle_PreEntity'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_FilteredPreEntity,NAMED('DBG_E_Person_Vehicle_FilteredPreEntity'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Result,NAMED('DBG_E_Person_Vehicle_Result'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_PreEntity,NAMED('DBG_E_Vehicle_PreEntity'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_FilteredPreEntity,NAMED('DBG_E_Vehicle_FilteredPreEntity'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_Result,NAMED('DBG_E_Vehicle_Result'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Intermediate_10,NAMED('DBG_E_Person_Vehicle_Intermediate_10'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Intermediate_9,NAMED('DBG_E_Person_Vehicle_Intermediate_9'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_Intermediate_9,NAMED('DBG_E_Vehicle_Intermediate_9'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Intermediate_8,NAMED('DBG_E_Person_Vehicle_Intermediate_8'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_Intermediate_8,NAMED('DBG_E_Vehicle_Intermediate_8'));
OUTPUT(__RoxieQuery.DBG_E_Person_Intermediate_7,NAMED('DBG_E_Person_Intermediate_7'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Intermediate_7,NAMED('DBG_E_Person_Vehicle_Intermediate_7'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_Intermediate_7,NAMED('DBG_E_Vehicle_Intermediate_7'));
OUTPUT(__RoxieQuery.DBG_E_Person_Intermediate_6,NAMED('DBG_E_Person_Intermediate_6'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Intermediate_6,NAMED('DBG_E_Person_Vehicle_Intermediate_6'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_Intermediate_6,NAMED('DBG_E_Vehicle_Intermediate_6'));
OUTPUT(__RoxieQuery.DBG_E_Person_Intermediate_5,NAMED('DBG_E_Person_Intermediate_5'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Intermediate_5,NAMED('DBG_E_Person_Vehicle_Intermediate_5'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_Intermediate_5,NAMED('DBG_E_Vehicle_Intermediate_5'));
OUTPUT(__RoxieQuery.DBG_E_Person_Intermediate_4,NAMED('DBG_E_Person_Intermediate_4'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Intermediate_4,NAMED('DBG_E_Person_Vehicle_Intermediate_4'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_Intermediate_4,NAMED('DBG_E_Vehicle_Intermediate_4'));
OUTPUT(__RoxieQuery.DBG_E_Person_Intermediate_3,NAMED('DBG_E_Person_Intermediate_3'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Intermediate_3,NAMED('DBG_E_Person_Vehicle_Intermediate_3'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_Intermediate_3,NAMED('DBG_E_Vehicle_Intermediate_3'));
OUTPUT(__RoxieQuery.DBG_E_Person_Intermediate_2,NAMED('DBG_E_Person_Intermediate_2'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Intermediate_2,NAMED('DBG_E_Person_Vehicle_Intermediate_2'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_Intermediate_2,NAMED('DBG_E_Vehicle_Intermediate_2'));
OUTPUT(__RoxieQuery.DBG_E_Person_Intermediate_1,NAMED('DBG_E_Person_Intermediate_1'));
OUTPUT(__RoxieQuery.DBG_E_Person_Vehicle_Intermediate_1,NAMED('DBG_E_Person_Vehicle_Intermediate_1'));
OUTPUT(__RoxieQuery.DBG_E_Vehicle_Intermediate_1,NAMED('DBG_E_Vehicle_Intermediate_1'));
OUTPUT(__RoxieQuery.DBG_E_Person_Annotated,NAMED('DBG_E_Person_Annotated'));
