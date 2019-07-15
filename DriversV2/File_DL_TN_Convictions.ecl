import DriversV2;

export File_DL_TN_Convictions (STRING filedate) := function
	return DATASET(DriversV2.Constants.Cluster + 'in::dl2::TN_CP_Clean_Update::'+ fileDate, Layouts_DL_TN_In.Layout_TN_CP_All_Cleaned, THOR);
end;