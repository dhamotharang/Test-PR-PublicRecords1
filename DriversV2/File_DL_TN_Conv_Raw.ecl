EXPORT File_DL_TN_Conv_Raw (STRING filedate) := FUNCTION
	RETURN DATASET(DriversV2.Constants.cluster+'in::dl2::TN_CP_Update::'+ filedate, DriversV2.Layouts_DL_TN_In.Layout_TN_CP_With_ProcessDte, THOR);
END;