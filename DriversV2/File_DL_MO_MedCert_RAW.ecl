EXPORT File_DL_MO_MedCert_RAW (STRING filedate) := FUNCTION
  RETURN DATASET(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::MO_MedCert_Update_Raw',
         DriversV2.Layouts_DL_MO_New_In.Layout_MO_Raw,
				 CSV(HEADING(0),SEPARATOR(['\t']),TERMINATOR(['\n','\r\n','\n\r'])));
END;