export File_DL_MO_Basic_Update(string filedate) := function
	return dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::MO_Basic_Update_Raw', DriversV2.Layouts_DL_MO_In.Layout_MO_Basic,thor);
end;
