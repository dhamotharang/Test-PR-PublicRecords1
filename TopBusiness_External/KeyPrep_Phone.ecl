import tools;
export KeyPrep_Phone(
	dataset(TopBusiness_External.Layouts.Phone) in_base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	slim := dedup(sort(project(in_base,KeyLayouts.Phone),record),record);
	
	tools.mac_FilesIndex('slim,{slim}',keynames(version,pUseOtherEnvironment).Phone,idx);
	
	return idx;

end;
