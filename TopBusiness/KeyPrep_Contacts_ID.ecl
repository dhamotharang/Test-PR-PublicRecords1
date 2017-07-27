import ut, MDR,tools;
export KeyPrep_Contacts_ID(
	dataset(Layout_Contacts.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function
  string8 CurDate := stringlib.getDateYYYYMMDD();
	projected := join(base,TopBusiness.Constants.ExecutiveOrder,
	                  left.position_title = right.position_title,
										// do we want to sort base by position Title?
	                  transform(KeyLayouts.Contacts, 
												self.source_docid_1 := map(
													MDR.SourceTools.SourceIsProperty(left.source) => left.source_docid[1],
													''),
												self.IsExecutive := right.IsExecutive;										
												self.IsCurrent := if (left.date_last_seen <> 0, 
												                       left.date_last_seen >= 
																									(unsigned4) ut.DateFrom_DaysSince1900(ut.DaysSince1900(CurDate[1..4], 
																				                           CurDate[5..6], CurDate[7..8]) - (integer)'365'),
																							   false);
	                  self := left),
										left outer,Lookup); 
	
	deduped := rollup(sort(distribute(projected,hash64(bid)),bid,record,except date_first_seen,date_last_seen,local),
		transform(KeyLayouts.Contacts,
			self.date_first_seen := min(left.date_first_seen,right.date_first_seen),
			self.date_last_seen := max(left.date_first_seen,right.date_first_seen),
			self := left),
		bid,record,except date_first_seen,date_last_seen,local);
	
	tools.mac_FilesIndex('deduped,{bid,IsExecutive,IsCurrent},{deduped}',keynames(version,pUseOtherEnvironment).Contacts,idx);
	
	return idx;

end;
