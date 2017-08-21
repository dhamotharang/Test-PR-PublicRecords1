IMPORT DriversV2;
export File_DL_TX_Update(string filedate) := function
	return dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::TX_Update_Raw', DriversV2.Layouts_DL_TX_Update.Layout_DL_TX_Update_Raw,
				 CSV(HEADING(0),SEPARATOR(['\t']),TERMINATOR(['\n','\r\n','\n\r'])));
end;