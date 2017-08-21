export File_DL_MO_Icissu_Update(string filedate) := function
	return dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::MO_Icissu_Update_Raw', DriversV2.Layouts_DL_MO_In.Layout_MO_Icissu,thor);
end;
