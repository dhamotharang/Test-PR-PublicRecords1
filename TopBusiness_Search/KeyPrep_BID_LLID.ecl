import TopBusiness;

export KeyPrep_BID_LLID(
	dataset(TopBusiness.Layout_LLID.Linked) in_base,
	string version) := function

	base := project(in_base(llid != 0),
		transform(KeyLayouts.LLID,
			self.core := true,
			self := left));
	
	idx := index(base,{base},KeyNames.LLID + version);
	
	return idx;

end;