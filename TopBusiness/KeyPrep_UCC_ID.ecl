import MDR,tools;

export KeyPrep_UCC_ID(
	dataset(Layout_UCC.Main.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	modified := project(base,
		transform(KeyLayouts.UCC.Main,
			self.party_type := left.source_party[1],
			self.source_docid_1 := map(
				MDR.SourceTools.SourceIsProperty(left.source) => left.source_docid[1],
				''),
			self.orig_filing_date_9999 := 99999999 - (unsigned4)left.orig_filing_date,
			self := left));
	
	deduped := dedup(modified,record,all);
	
	tools.mac_FilesIndex('deduped,{bid,party_type,status_code,orig_filing_date_9999},{deduped}',keynames(version,pUseOtherEnvironment).UCC.Main,idx);
	
	return idx;

end;