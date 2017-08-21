import TopBusiness,tools;

export KeyPrep_BID_CompanyName(
	dataset(TopBusiness.Layout_Linking.Linked) in_base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	// Remove property addresses - we don't want to find BIDs using property addresses
	filtered := in_base(address_type not in [TopBusiness.Constants.Address_Types.PROPERTY,TopBusiness.Constants.Address_Types.REGAGENT]);
	
	TopBusiness.Macro_CleanCompanyName(filtered,company_name,company_name,cleaned);
	
	cleanedpersist := cleaned;
	
	pattern p_word := pattern('[^ ]+');
	pattern p_ws := pattern('[ ]+');
	pattern p_phrase := p_word (p_ws p_word)*;
	pattern p_find := (p_phrase after (first or p_ws)) before (p_ws or last);
	
	ds_parsed := parse(
		dedup(dedup(project(cleanedpersist,
			transform(KeyLayouts.CompanyName,
				self.core := left.segment_bid in TopBusiness.Constants.SET_CORE_SEGMENTS,
				self:=left,self:=[])),record,all,local),record,all),
		company_name,
		p_find,
		transform(KeyLayouts.CompanyName,
			self.ph_phrase := metaphonelib.dmetaphone2(matchtext(p_phrase)),
			self.phrase := matchtext(p_phrase),
			self := left),
		scan all);

	final_ds := dedup(dedup(ds_parsed,record,all,local),record,all);
	
	tools.mac_FilesIndex('final_ds,{final_ds}',keynames(version,pUseOtherEnvironment).CompanyName,idx);
	
	return idx;

end;
