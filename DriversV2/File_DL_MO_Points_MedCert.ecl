EXPORT File_DL_MO_Points_MedCert (STRING filedate) := function
	return dataset(DriversV2.Constants.Cluster + 'in::dl2::mo_points_cp_update::'+filedate, DriversV2.Layouts_DL_MO_New_In.Layout_MO_Points_Pdate, thor);
end;