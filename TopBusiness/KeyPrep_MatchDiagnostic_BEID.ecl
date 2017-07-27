import tools;
export KeyPrep_MatchDiagnostic_BEID(
	dataset(Layout_Linking.Match) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := dedup(dedup(normalize(base,2,transform(
		KeyLayouts.MatchDiagnostic,
		self.beid1 := choose(counter,left.beid_low,left.beid_high),
		self.beid2 := choose(counter,left.beid_high,left.beid_low),
		self := left)),record,all,local),record,all);
	
	tools.mac_FilesIndex('projected,{beid1,beid2},{projected}',keynames(version,pUseOtherEnvironment).MatchDiagnostic,idx);
	
	return idx;

end;
