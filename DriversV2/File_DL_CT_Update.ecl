export File_DL_CT_Update(string filedate) := function
	return dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::CT_Update_Raw', DriversV2.Layouts_DL_CT_In.Layout_CT_Update,
	               CSV(SEPARATOR(['|']),QUOTE('"'), TERMINATOR(['\r\n', '\n']))
								 );
		
end;