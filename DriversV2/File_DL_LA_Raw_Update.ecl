import DriversV2;

export File_DL_LA_Raw_Update(string filedate) := function
	return dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::LA_Update_Raw', DriversV2.Layout_DL_LA_In.Raw,thor);
end;