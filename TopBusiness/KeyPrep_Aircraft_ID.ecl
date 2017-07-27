import tools;

export KeyPrep_Aircraft_ID(
	dataset(Layout_Aircraft.Main.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base,
		transform(KeyLayouts.Aircraft.Main,
			self.date_9999 := if((unsigned4)left.date_last_seen = 0,0,99999999 - (unsigned4)left.date_last_seen),
			self.source_docid_1 := left.source_docid[1],
			self := left));
	
	deduped := dedup(sort(projected,bid,source,source_docid_1,serial_number,registration_date,if(current_prior_flag = 'A',0,1),-date_last_seen,record),bid,source,source_docid_1,serial_number,registration_date);
	
	                                   // serial_number stays same via life of airacraft
																		 // registration_number (n_number) does not.
	tools.mac_FilesIndex('deduped,{bid,current_prior_flag,date_9999},{projected}',keynames(version,pUseOtherEnvironment).Aircraft.Main,idx);
	
	return idx;

end;