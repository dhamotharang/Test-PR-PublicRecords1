EXPORT File_DL_WY_MedCert_Update:= FUNCTION
	RETURN DATASET(DriversV2.Constants.cluster+'in::dl2::WY_medcert_clean_updates::superfile', DriversV2.Layouts_DL_WY_In.Layout_WY_MedCert_Cleaned,thor);
END;