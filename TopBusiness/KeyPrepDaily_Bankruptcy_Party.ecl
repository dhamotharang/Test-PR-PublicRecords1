import tools;

export KeyPrepDaily_Bankruptcy_Party(
	dataset(Layout_Bankruptcy.Party) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base,KeyLayouts.Bankruptcy.Party);
	
	tools.mac_FilesIndex('projected,{court_code,orig_case_number},{projected}',keynamesdaily(version,pUseOtherEnvironment).Bankruptcy.Party,idx);
	
	return idx;

end;
