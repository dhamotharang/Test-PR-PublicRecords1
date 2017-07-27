import MDR,tools;

export KeyPrep_AddressesPhones_ID(
	dataset(Layout_Linking.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected_1 := rollup(sort(project(base,
		transform(KeyLayouts.AddressesPhones,
			self.source_docid_1 := map(
				MDR.SourceTools.SourceIsProperty(left.source) => left.source_docid[1],
				''),
			self := left)),record,except date_first_seen,date_last_seen,local),
		transform(KeyLayouts.AddressesPhones,
			self.date_first_seen := min(left.date_first_seen,right.date_first_seen),
			self.date_last_seen := max(left.date_last_seen,right.date_last_seen),
			self := left),
		record,except date_first_seen,date_last_seen,local);

	projected := rollup(sort(projected_1,record,except date_first_seen,date_last_seen),
		transform(KeyLayouts.AddressesPhones,
			self.date_first_seen := min(left.date_first_seen,right.date_first_seen),
			self.date_last_seen := max(left.date_last_seen,right.date_last_seen),
			self := left),
		record,except date_first_seen,date_last_seen);

	tools.mac_FilesIndex('projected,{bid},{projected}',keynames(version,pUseOtherEnvironment).AddressesPhones,idx);
	
	return idx;

end;
