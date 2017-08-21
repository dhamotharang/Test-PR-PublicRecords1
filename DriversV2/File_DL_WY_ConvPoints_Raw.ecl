EXPORT File_DL_WY_ConvPoints_Raw(STRING filedate) := FUNCTION
	RETURN DATASET(DriversV2.Constants.cluster+'in::dl2::WY_CP_Update::'+ filedate, DriversV2.Layouts_DL_WY_In.Layout_WY_CP_With_ProcessDte,THOR);
END;