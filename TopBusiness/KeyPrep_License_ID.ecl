import tools;
export KeyPrep_License_ID(
	dataset(Layout_License.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base,
		transform(KeyLayouts.License,
			self.source_docid_1 := left.source_docid[1],
			self := left));
	
	tools.mac_FilesIndex('projected,{bid},{projected}',keynames(version,pUseOtherEnvironment).License,idx);
	
	return idx;

end;