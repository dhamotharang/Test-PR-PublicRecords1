import DriversV2;

export File_DL_NV_Raw_Update(string filedate) := function
	return dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::NV_Update_Raw', DriversV2.Layout_DL_NV_In.Raw,thor);
end;