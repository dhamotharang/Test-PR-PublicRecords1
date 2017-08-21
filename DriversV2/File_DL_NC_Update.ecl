export File_DL_NC_Update(string filedate) := function
	return dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::NC_Update_Raw', DriversV2.Layout_DL_NC_In.Layout_NC_Update,csv(Heading(1),separator('$'),quote('"'),terminator('\n')));
end;