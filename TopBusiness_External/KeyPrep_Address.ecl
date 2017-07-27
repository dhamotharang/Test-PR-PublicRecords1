import tools;
export KeyPrep_Address(
	dataset(TopBusiness_External.Layouts.Address) in_base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	slim := dedup(sort(project(in_base,KeyLayouts.Address),record),record);
	
	tools.mac_FilesIndex('slim,{slim}',keynames(version,pUseOtherEnvironment).Address,idx);
	
	return idx;

end;
