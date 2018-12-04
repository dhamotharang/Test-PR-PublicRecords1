export File_DL_MA_Update(string filedate) := function
	return dataset(	DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::MA_Update_Raw',
									DriversV2.Layout_DL_MA_In.Raw,
									csv(heading(1),separator('||'),terminator(['\r\n','\r','\n']),quote('"')));
end;