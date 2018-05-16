IMPORT DriversV2;
EXPORT In_tn_conv(string filedate) := Dataset(DriversV2.Constants.cluster + 'in::dl2::tn_cp_clean_update::'+filedate , Scrubs_DL_TN_CONV.Layout_In_tn_conv, THOR);
//EXPORT In_tn_conv:= Dataset(DriversV2.Constants.cluster + 'in::dl2::tn_cp_clean_update::20180312' , Scrubs_DL_TN_CONV.Layout_In_tn_conv, THOR);
