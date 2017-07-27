import tools;
export KeyPrep_Watercraft_ID(
	dataset(Layout_Watercraft.Main.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

  // Create 3 special key fields to assist in the report when "looking up" recs for a bid
	base_modified := project(base,
	  transform(KeyLayouts.Watercraft.main,
			self.current_prior    := if(left.history_flag='',Constants.CURRENT,Constants.PRIOR),
			self.regist_date_9999 := 99999999 - (unsigned4)left.registration_date,
			self.party_type       := left.source_party[1],
			self.source_docid_1   := left.source_docid[1],
			self := left));
	
	tools.mac_FilesIndex('base_modified,{bid,current_prior,regist_date_9999, party_type},{base_modified}',keynames(version,pUseOtherEnvironment).Watercraft.Main,idx);
	
	return idx;

end;
