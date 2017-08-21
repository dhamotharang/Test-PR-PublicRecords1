import Drivers;

export File_DL_WI_Raw(string filedate) := function
	return dataset(Drivers.cluster+'in::dl2::' + filedate + '::wi_update_raw', DriversV2.Layouts_DL_WI_In.Layout_WI_Update,thor);
end;
