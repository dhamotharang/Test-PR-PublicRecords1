export File_DL_OH_Update(string filedate) := function

	// For legal reasons any record for Edward Kimito needs to be suppressed from the OH DL files. See DF-24042 for more info.
	return dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::OH_Update_Raw', DriversV2.Layouts_DL_OH_In.Layout_OH_Update,thor)(pimnam<>'KOMITO*EDWARD,L');
end;
