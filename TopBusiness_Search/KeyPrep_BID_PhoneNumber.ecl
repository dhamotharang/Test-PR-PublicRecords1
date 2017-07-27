import TopBusiness,tools;

export KeyPrep_BID_PhoneNumber(
	dataset(TopBusiness.Layout_Linking.Linked) in_base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := in_base(phone != '');
	
	slim := dedup(sort(project(base,
		transform(KeyLayouts.PhoneNumber,
			self.core := left.segment_bid in TopBusiness.Constants.SET_CORE_SEGMENTS,
			self := left)),record),record);
	
	tools.mac_FilesIndex('slim,{slim}',keynames(version,pUseOtherEnvironment).PhoneNumber,idx);
	
	return idx;

end;
