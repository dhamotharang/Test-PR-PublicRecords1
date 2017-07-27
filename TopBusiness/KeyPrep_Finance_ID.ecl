import tools;
export KeyPrep_Finance_ID(
	dataset(Layout_Finance.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base,
		transform(KeyLayouts.Finance,
			self.source_docid_1 := left.source_docid[1],
			self := left));
	
	tools.mac_FilesIndex('projected,{bid},{projected}',keynames(version,pUseOtherEnvironment).Finance,idx);
	
	return idx;

end;