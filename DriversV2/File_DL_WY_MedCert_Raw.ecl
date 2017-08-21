EXPORT File_DL_WY_MedCert_Raw (STRING filedate) := FUNCTION
	RETURN DATASET(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::WY_MedCert_Update_Raw', DriversV2.Layouts_DL_WY_In.Layout_WY_MedCert_Update,thor);
END;