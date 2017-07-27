import tools;
export KeyPrep_MotorVehicle_Title(
	dataset(Layout_MotorVehicle.Title) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base_modified := project(base,
		transform(KeyLayouts.MotorVehicle.Title,
			self.date_9999 := 99999999 - (unsigned4)left.title_date,
			self := left));
	
	deduped := dedup(base_modified,record,all);
	
	tools.mac_FilesIndex('deduped,{vehicle_id,vendor},{deduped}',keynames(version,pUseOtherEnvironment).MotorVehicle.Title,idx);
	
	return idx;

end;
