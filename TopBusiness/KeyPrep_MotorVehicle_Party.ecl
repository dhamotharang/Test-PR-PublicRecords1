import tools;
export KeyPrep_MotorVehicle_Party(
	dataset(Layout_MotorVehicle.Party.Linked) prebase,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := prebase(event_id != '');

	base_modified := project(base,KeyLayouts.MotorVehicle.Party);
	
	tools.mac_FilesIndex('base_modified,{vendor,event_id},{base_modified}',keynames(version,pUseOtherEnvironment).MotorVehicle.Party,idx);
	
	return idx;

end;
