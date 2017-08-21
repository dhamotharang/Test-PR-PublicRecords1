import TopBusiness,tools;

export KeyPrep_BID_Address(
	dataset(TopBusiness.Layout_Linking.Linked) in_base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	// Remove property addresses; we don't want to find BIDs using those.
	base := in_base(zip != '' and address_type not in [TopBusiness.Constants.Address_Types.PROPERTY,TopBusiness.Constants.Address_Types.REGAGENT]);
	
	slim := dedup(sort(project(base,
		transform(KeyLayouts.Address,
			self.core := left.segment_bid in TopBusiness.Constants.SET_CORE_SEGMENTS,
			self := left)),record),record);
	
	tools.mac_FilesIndex('slim,{slim}',keynames(version,pUseOtherEnvironment).Address,idx);
	
	return idx;

end;
