import tools;
export KeyPrep_FEIN(
	dataset(TopBusiness_External.Layouts.FEIN) in_base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	slim := dedup(sort(project(in_base,KeyLayouts.FEIN),record),record);
	
	tools.mac_FilesIndex('slim,{slim}',keynames(version,pUseOtherEnvironment).FEIN,idx);
	
	return idx;

end;
