import MDR,tools;

export KeyPrep_Property_ID(
	dataset(Layout_Property.Main.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	modified := project(base,
		transform(KeyLayouts.Property.Main,			
			self.party_type := left.source_party[1]; // put back in later
			 self.current_flag := left.current_flag; // string1   current_record
			 self.source_docid_1 := map(
				MDR.SourceTools.SourceIsProperty(left.source) => left.source_docid[1],
				''),
				self.date_9999 :=  99999999 - (unsigned4)left.owner_date * 100;		
			self := left));
	
	deduped := dedup(modified,record,all);
	
	tools.mac_FilesIndex('deduped,{bid,current_flag,party_type,date_9999},{deduped}',keynames(version,pUseOtherEnvironment).Property.Main,idx);
	
	return idx;

end;