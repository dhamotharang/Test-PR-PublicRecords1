import tools;
export KeyPrep_LinkDiagnostic_BEID(
	dataset(Layout_Linking.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base,KeyLayouts.LinkDiagnostic);
	
	tools.mac_FilesIndex('projected,{beid},{projected}',keynames(version,pUseOtherEnvironment).LinkDiagnostic,idx);
	
	return idx;

end;
