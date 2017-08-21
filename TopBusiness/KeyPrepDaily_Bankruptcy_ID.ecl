import MDR,tools;

export KeyPrepDaily_Bankruptcy_ID(
	dataset(Layout_Bankruptcy.Main.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	modified := project(base,
		transform(KeyLayouts.Bankruptcy.Main,
			self.party_type := left.source_party[1],
			self.date_filed_9999 := 99999999 - (unsigned4)left.date_filed,
			self.source_docid_1 := map(
				MDR.SourceTools.SourceIsProperty(left.source) => left.source_docid[1],
				''),
			self := left));
	
	deduped := dedup(modified,record,all);
	
	tools.mac_FilesIndex('deduped,{bid,party_type,date_filed_9999},{deduped}',keynamesdaily(version,pUseOtherEnvironment).Bankruptcy.Main,idx);
	
	return idx;

end;
