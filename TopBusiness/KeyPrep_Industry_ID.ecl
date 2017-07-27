import MDR,tools;

export KeyPrep_Industry_ID(
	dataset(Layout_Industry.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base,
		transform(KeyLayouts.Industry,
			self.source_docid_1 := map(
				MDR.SourceTools.SourceIsProperty(left.source) => left.source_docid[1],
				''),
			self := left));
	
	deduped := dedup(projected,record,all);
	
	tools.mac_FilesIndex('deduped,{bid},{deduped}',keynames(version,pUseOtherEnvironment).Industry,idx);
	
	return idx;

end;