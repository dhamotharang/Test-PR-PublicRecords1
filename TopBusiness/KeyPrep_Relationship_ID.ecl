import tools;
export KeyPrep_Relationship_ID(
	dataset(Layout_Relationship.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	norm_base := normalize(base,2,transform(KeyLayouts.Relationship,
		self.bid := choose(counter,left.bid_1,left.bid_2),
		self.other_bid := choose(counter,left.bid_2,left.bid_1),
		self.role := choose(counter,left.role_1,left.role_2),
		self.other_role := choose(counter,left.role_2,left.role_1),
		self.source := choose(counter,left.source_1,left.source_2),
		self.other_source := choose(counter,left.source_2,left.source_1),
		self.source_docid_1 := choose(counter,left.source_docid_1[1],left.source_docid_2[1]),
		self.other_source_docid_1 := choose(counter,left.source_docid_2[1],left.source_docid_1[1])));
	
	dedup_base := dedup(norm_base(bid != other_bid),record,all);
	
	tools.mac_FilesIndex('dedup_base,{bid},{dedup_base}',keynames(version,pUseOtherEnvironment).Relationship,idx);
	
	return idx;

end;
