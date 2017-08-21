export File_DL_MN_Update(string filedate) := function
	return dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::MN_Update_Raw', DriversV2.Layouts_DL_MN_New_In.Layout_MN_Update,thor);
end;
