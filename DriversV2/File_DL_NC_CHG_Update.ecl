EXPORT File_DL_NC_CHG_Update(string filedate) := function
	in_file:= dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::nc_chg_update_raw', DriversV2.Layout_DL_NC_In.Layout_CHG_Update,csv(Heading(1),separator('$'),quote('"'),terminator('\n')));
	return project(in_file,transform(DriversV2.Layout_DL_NC_In.Layout_NC_Update,self:=left));
end;