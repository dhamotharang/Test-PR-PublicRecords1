EXPORT File_DL_MO_Accidents (STRING filedate) := function
	return DATASET(DriversV2.Constants.Cluster + 'in::dl2::mo_accidents_cp_update::'+filedate, Layouts_DL_MO_New_In.Layout_MO_Accidents_Pdate, THOR);
end;
