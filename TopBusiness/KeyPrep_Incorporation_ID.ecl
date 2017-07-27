import tools;
export KeyPrep_Incorporation_ID(
	dataset(Layout_Incorporation.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base,
		transform(KeyLayouts.Incorporation,
			self.source_docid_1 := left.source_docid[1],
			self := left));
	
	tools.mac_FilesIndex('projected,{bid},{projected}',keynames(version,pUseOtherEnvironment).Incorporation,idx);
	
	return idx;

end;