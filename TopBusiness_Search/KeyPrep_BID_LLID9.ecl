import TopBusiness,tools;

export KeyPrep_BID_LLID9(
	dataset(TopBusiness.Layout_LLID.LLID9.Linked) in_base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := project(in_base(llid9 != 0),
		transform(KeyLayouts.LLID9,
			self := left));
	
	deduped := dedup(dedup(base,record,all,local),record,all);
	
	tools.mac_FilesIndex('deduped,{deduped}',keynames(version,pUseOtherEnvironment).LLID9,idx);
	
	return idx;

end;