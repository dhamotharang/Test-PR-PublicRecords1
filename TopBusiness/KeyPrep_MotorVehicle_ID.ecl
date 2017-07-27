import MDR,tools;

export KeyPrep_MotorVehicle_ID(
	dataset(Layout_MotorVehicle.Main.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

  // Create 3(?) special key fields to assist in the report when "looking up" recs for a bid
	base_modified := project(base(bid != 0),
	  transform(KeyLayouts.MotorVehicle.main,
			self.source_docid_1 := map(
				MDR.SourceTools.SourceIsProperty(left.source) => left.source_docid[1],
				''),
			self := left));
	
	deduped := dedup(base_modified,record,all);
	
	tools.mac_FilesIndex('deduped,{bid, party_type,current_prior,key_date_9999},{deduped}',keynames(version,pUseOtherEnvironment).MotorVehicle.Main,idx);
	
	return idx;

end;
