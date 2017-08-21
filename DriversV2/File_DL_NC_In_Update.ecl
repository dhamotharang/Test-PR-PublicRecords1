
NC_Chg_Update := dataset(DriversV2.Constants.cluster + 'in::dl2::nc_chg_clean_updates::superfile',	DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean,thor);
NC_New_Update := dataset(DriversV2.Constants.cluster + 'in::dl2::nc_clean_updates::superfile',DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean,thor);

EXPORT File_DL_NC_In_Update := dedup(sort(NC_Chg_Update + NC_New_Update,record),record);