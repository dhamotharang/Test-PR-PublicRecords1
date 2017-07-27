import tools;
export KeyPrep_MotorVehicle_Registration(
	dataset(Layout_MotorVehicle.Registration) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base_modified := project(base,
		transform(KeyLayouts.MotorVehicle.Registration,
			self.date_9999 := 99999999 - (unsigned4)left.registration_date,
			self := left));
	
	deduped := dedup(base_modified,record,all);
	
	tools.mac_FilesIndex('deduped,{vehicle_id,vendor},{deduped}',keynames(version,pUseOtherEnvironment).MotorVehicle.Registration,idx);
	
	return idx;

end;
