IMPORT DriversV2;
EXPORT In_TN_WDL(string filedate) := Dataset(DriversV2.Constants.cluster + 'in::dl2::tn_wdl_cp_clean_update::'+filedate , Scrubs_DL_TN_WDL.layout_In_TN_WDL, THOR);
//EXPORT In_TN_WDL := Dataset(DriversV2.Constants.cluster + 'in::dl2::tn_wdl_cp_clean_update:::20180312'  , Scrubs_DL_TN_WDL.layout_In_TN_WDL, THOR);
