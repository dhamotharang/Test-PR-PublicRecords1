import tools;
export KeyPrep_Liens_ID(
	dataset(Layout_Liens.Main.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	modified := project(base,
		transform(KeyLayouts.Liens.Main,
		  // check multiple fields to determine if filing is terminated 
			// (i.e. released/satisfied/vacated/lapsed/expired)
			self.status_code := map(
			  (left.release_date !=''      or 
			   left.satisfaction_type in ['FULL','YES', 'VACATE']           or
				 left.judg_satisfied_date !='' or left.judg_vacated_date !='' or 
				 left.lapse_date !=''          or left.expiration_date != ''  or
				 left.filing_type_desc in ['TERMINATION'] 
				) => TopBusiness.Constants.TERMINATED,
				// otherwise it's "Active"
				TopBusiness.Constants.ACTIVE),
      self.orig_filing_date_9999 := 99999999 - (unsigned4)if(left.orig_filing_date != '',
			                                                       left.orig_filing_date,
																														 left.filing_date);
			self.party_type := left.source_party[1],
			self.source_docid_1 := left.source_docid[1],
		  self := left));
	
	tools.mac_FilesIndex('modified,{bid,status_code,orig_filing_date_9999},{modified}',keynames(version,pUseOtherEnvironment).Liens.Main,idx);

	return idx;

end;