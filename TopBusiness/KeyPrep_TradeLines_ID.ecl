import tools;
export KeyPrep_TradeLines_ID(
	dataset(Layout_TradeLines.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base,
		transform(KeyLayouts.TradeLines,
			self.source_docid_1 := left.source_docid[1],
			self := left));
	
	tools.mac_FilesIndex('projected,{bid},{projected}',keynames(version,pUseOtherEnvironment).TradeLines,idx);
	
	return idx;

end;
