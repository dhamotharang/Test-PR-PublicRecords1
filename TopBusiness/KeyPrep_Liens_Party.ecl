import tools;
export KeyPrep_Liens_Party(
	dataset(Layout_Liens.Party) prebase,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := prebase(tmsid != '');
	
	projected := project(base,KeyLayouts.Liens.Party);
	
	tools.mac_FilesIndex('projected,{tmsid,party_type},{projected}',keynames(version,pUseOtherEnvironment).Liens.Party,idx);
	
	return idx;

end;