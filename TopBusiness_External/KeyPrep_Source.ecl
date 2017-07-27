import tools;
export KeyPrep_Source(
	dataset(TopBusiness_External.Layouts.Source) in_base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	slim := dedup(sort(project(in_base,KeyLayouts.Source),record),record);
	
	tools.mac_FilesIndex('slim,{slim}',keynames(version,pUseOtherEnvironment).Source,idx);
	
	return idx;

end;
