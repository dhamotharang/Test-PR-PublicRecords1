import tools;
export KeyPrep_Foreclosure_Party(
	dataset(Layout_Foreclosure.Party.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base,KeyLayouts.Foreclosure.Party);
	
	tools.mac_FilesIndex('projected,{foreclosure_id},{projected}',keynames(version,pUseOtherEnvironment).Foreclosure.Party,idx);
	
	return idx;

end;