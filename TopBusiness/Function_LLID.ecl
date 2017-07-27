export Function_LLID(
	dataset(Layout_Linking.Linked) linkage,
	dataset(Layout_LLID.Linked) old_llids = dataset([],Layout_LLID.Linked)) := function
	
	// Normalize out our linkage set to create three records for each BEID: one with the BID only, one with BID/BRID, one with BID/BRID/BLID.
	normalized_linkage := normalize(linkage,3,
		transform({Layout_LLID.Linked;boolean core;},
			self.core := left.segment_bid in Constants.SET_CORE_SEGMENTS,
			self.bid := left.bid,
			self.brid := if(counter < 3,left.brid,0),
			self.blid := if(counter < 2,left.blid,0),
			self.beid := left.beid,
			self := []));
	
	// Now dedup out the duplicates
	deduped_normalized_linkage := dedup(normalized_linkage,record,all);
	
	// Now, since our BEIDs are assigned and DO never change, we need to make sure that all the BEIDs that had been assigned
	// to a particular LLID are still all together.  If not, we hold them out and deal with them separately.
	add_previous_llids := join(
		distribute(deduped_normalized_linkage,hash64(beid)),
		distribute(old_llids,hash64(beid)),
		left.beid = right.beid and
		(
			(left.brid != 0 and left.blid != 0 and right.brid != 0 and right.blid != 0) or
			(left.brid != 0 and left.blid  = 0 and right.brid != 0 and right.blid  = 0) or
			(left.brid  = 0 and left.blid  = 0 and right.brid  = 0 and right.blid  = 0)
		),
		transform(Layout_LLID.Linked,
			self.llid12 := right.llid12,
			self.llid9  := right.llid9,
			self := left),
		local);
	
	// In order to check this, we need to roll up all of our records and count how many different BID/BRID/BLIDs each LLID12
	// is associated with.  Any that are associated with exactly ONE are okay by definition.  After that, if somehow an
	// LLID12 was split, we'll take the BID/BRID/BLID that has the most contributors from the original LLID12
	llid12_count_associated :=
		table(
			table(
				add_previous_llids,
				{llid12,bid,brid,blid,unsigned cnt := count(group)},
				llid12,bid,brid,blid,local),
			{llid12,bid,brid,blid,unsigned cnt := sum(group,cnt)},
			llid12,bid,brid,blid);
	llid12_associated_bidbridblids := dedup(sort(llid12_count_associated,llid12,-cnt,bid,brid,blid),llid12);
	
	// Now take all LLID12s associated with a BID/BRID/BLID, select the most frequent, then the lowest
	best_llid12_for_bidbridblid := dedup(sort(llid12_associated_bidbridblids,bid,brid,blid,-cnt,llid12),bid,brid,blid);
	
	// Same thing with llid9
	llid9_count_associated :=
		table(
			table(
				add_previous_llids(llid9 != 0),
				{llid9,bid,brid,blid,unsigned cnt := count(group)},
				llid9,bid,brid,blid,local),
			{llid9,bid,brid,blid,unsigned cnt := sum(group,cnt)},
			llid9,bid,brid,blid);
	llid9_associated_bidbridblids := dedup(sort(llid9_count_associated,llid9,-cnt,bid,brid,blid),llid9);
	best_llid9_for_bidbridblid := dedup(sort(llid9_associated_bidbridblids,bid,brid,blid,-cnt,llid9),bid,brid,blid);
	
	// Now, apply these back to the original set of records we created earlier.
	apply_known_llid12s := join(
		distribute(deduped_normalized_linkage,hash64(bid,brid,blid)),
		distribute(best_llid12_for_bidbridblid,hash64(bid,brid,blid)),
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid,
		transform(recordof(deduped_normalized_linkage),
			self.llid12 := right.llid12,
			self := left),
		left outer,
		local);
	apply_known_llid9s := join(
		distribute(apply_known_llid12s,hash64(bid,brid,blid)),
		distribute(best_llid9_for_bidbridblid,hash64(bid,brid,blid)),
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid,
		transform(recordof(apply_known_llid12s),
			self.llid9 := right.llid9,
			self := left),
		left outer,
		local);
	
	// Now we need to apply new LLID12
	// Get the maximum previously-assigned LLID12
	max_llid12 := max(old_llids,llid12);
	
	// Filter down to the BID/BRID/BLIDs that require a new LLID12
	need_llid12 := dedup(apply_known_llid12s(llid12 = 0),bid,brid,blid,all);
	hash_llid12 := project(sort(need_llid12,hash64(bid,brid,blid)),
		transform(Layout_LLID.Linked,
			self.llid12 := max_llid12 + counter,
			self := left));
	
	// Now we need to apply new LLID9
	// Get the maximum previously-assigned LLID9
	max_llid9 := max(old_llids,llid9);
	
	// Filter down to the BID/BRID/BLIDs that require a new LLID9
	need_llid9 := dedup(apply_known_llid9s(core and llid9 = 0),bid,brid,blid,all);
	hash_llid9 := project(sort(need_llid9,hash64(bid,brid,blid)),
		transform(Layout_LLID.Linked,
			self.llid9 := max_llid9 + counter,
			self := left));
	
	// Now apply these
	apply_new_llid12s := join(
		distribute(apply_known_llid9s,hash64(bid,brid,blid)),
		distribute(hash_llid12,hash64(bid,brid,blid)),
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid,
		transform(Layout_LLID.Linked,
			self.llid12 := if(right.llid12 = 0,left.llid12,right.llid12),
			self := left),
		left outer,
		local);
	apply_new_llid9s := join(
		distribute(apply_new_llid12s,hash64(bid,brid,blid)),
		distribute(hash_llid9,hash64(bid,brid,blid)),
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid,
		transform(Layout_LLID.Linked,
			self.llid9 := if(right.llid9 = 0,left.llid9,right.llid9),
			self := left),
		left outer,
		local);
	
	return apply_new_llid9s;

end;