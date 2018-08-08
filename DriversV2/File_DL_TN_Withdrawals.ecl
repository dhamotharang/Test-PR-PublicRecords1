import DriversV2;

export File_DL_TN_Withdrawals (STRING filedate) := function
	return DATASET(DriversV2.Constants.Cluster + 'in::dl2::TN_WDL_CP_Clean_Update::'+ fileDate, Layouts_DL_TN_In.Layout_TN_WDL_All_Cleaned, THOR);
end;