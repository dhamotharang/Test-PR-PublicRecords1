EXPORT File_DL_TN_Update2_Raw(STRING filedate) := FUNCTION
	RETURN DATASET(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::TN_Update_Raw', DriversV2.Layouts_DL_TN_In.Layout_TN_Update2,THOR);
END;