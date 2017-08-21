EXPORT File_DL_WY_ConvPoints := FUNCTION
	RETURN DATASET(DriversV2.Constants.cluster + 'in::dl2::WY_CP_Clean_Updates::superfile', DriversV2.Layouts_DL_WY_In.Layout_WY_CP_Cln,thor);
END;