import TopBusiness,tools;

export KeyPrep_BID_LLID12(
	dataset(TopBusiness.Layout_LLID.Linked) in_base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := project(in_base(llid12 != 0),
		transform(KeyLayouts.LLID12,
			self.core := left.llid9 != 0,
			self := left));
	
	deduped := dedup(dedup(base,record,all,local),record,all);
	
	tools.mac_FilesIndex('deduped,{deduped}',keynames(version,pUseOtherEnvironment).LLID12,idx);
	
	return idx;

end;