import tools;

export KeyPrep_Abstract_ID(
	dataset(Layout_Abstract.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base,
		transform(KeyLayouts.Abstract,
			self.source_docid_1 := left.source_docid[1],
			self := left));
	
	tools.mac_FilesIndex('projected,{bid},{projected}',keynames(version,pUseOtherEnvironment).Abstract,idx);
	
	return idx;

end;