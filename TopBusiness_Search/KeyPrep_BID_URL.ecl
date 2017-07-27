import TopBusiness,tools;

export KeyPrep_BID_URL(
	dataset(TopBusiness.Layout_URLs.Linked) in_base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := in_base(cleanurl != '');
	
	slim := dedup(sort(project(base,
		transform(KeyLayouts.URL,
			self.core := left.segment_bid in TopBusiness.Constants.SET_CORE_SEGMENTS,
			self := left)),record),record);
	
	tools.mac_FilesIndex('slim,{slim}',keynames(version,pUseOtherEnvironment).URL,idx);
	
	return idx;

end;
