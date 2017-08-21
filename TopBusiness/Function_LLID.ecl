export Function_LLID(
	dataset(Layout_Linking.Linked) linkage,
	dataset(Layout_LLID.LLID12.Linked) old_llid12s = dataset([],Layout_LLID.LLID12.Linked),
	dataset(Layout_LLID.LLID9.Linked) old_llid9s = dataset([],Layout_LLID.LLID9.Linked)) := module
	
	// Normalize out our linkage set to create three records for each BEID: one with the BID only, one with BID/BRID, one with BID/BRID/BLID.
	normalized_linkage := normalize(linkage,3,
		transform(Layout_LLID.LLID12.Linked,
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
		distribute(old_llid12s,hash64(beid)),
		left.beid = right.beid and
		(
			(left.brid != 0 and left.blid != 0 and right.brid != 0 and right.blid != 0) or
			(left.brid != 0 and left.blid  = 0 and right.brid != 0 and right.blid  = 0) or
			(left.brid  = 0 and left.blid  = 0 and right.brid  = 0 and right.blid  = 0)
		),
		transform(Layout_LLID.LLID12.Linked,
			self.llid12 := right.llid12,
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
			
	// These are the BID/BRID/BLIDs "most closely associated" with old LLID12s
	llid12_associated_bidbridblids := dedup(sort(llid12_count_associated,llid12,-cnt,bid,brid,blid),llid12);
	
	// Now take all LLID12s associated with a BID/BRID/BLID, select the most frequent, then the lowest
	best_llid12_for_bidbridblid := dedup(sort(llid12_associated_bidbridblids,bid,brid,blid,-cnt,llid12),bid,brid,blid);
	
	// Let's find all the "non-winning" LLID12s for each BID/BRID/BLID... we'll use them to patch the old stuff.
	other_llid12s_for_bidbridblid := join(llid12_associated_bidbridblids,best_llid12_for_bidbridblid,
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid,
		transform(left),
		left only);
	
	// Now, apply the winning LLID12s back to the original set of records we created earlier.
	apply_known_best_llid12s :=
		join(
			distribute(deduped_normalized_linkage,hash64(bid,brid,blid)),
			distribute(best_llid12_for_bidbridblid,hash64(bid,brid,blid)),
			left.bid = right.bid and
			left.brid = right.brid and
			left.blid = right.blid,
			transform(recordof(deduped_normalized_linkage),
				self.llid12 := right.llid12,
				self.active12 := if(right.bid != 0,true,false),
				self := left),
			left outer,
			local);

	// Now we need to apply new LLID12
	// Get the maximum previously-assigned LLID12
	max_llid12 := max(old_llid12s,llid12);
	
	// Filter down to the BID/BRID/BLIDs that require a new LLID12
	need_llid12 := dedup(apply_known_best_llid12s(llid12 = 0),bid,brid,blid,all);
	hash_llid12 := project(sort(need_llid12,hash64(bid,brid,blid)),
		transform(Layout_LLID.LLID12.Linked,
			self.llid12 := max_llid12 + counter,
			self.active12 := true,
			self := left));
	
	// Now apply these
	apply_new_best_llid12s := join(
		distribute(apply_known_best_llid12s,hash64(bid,brid,blid)),
		distribute(hash_llid12,hash64(bid,brid,blid)),
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid,
		transform(Layout_LLID.LLID12.Linked,
			self.llid12 := if(right.llid12 = 0,left.llid12,right.llid12),
			self.active12 := if(right.llid12 = 0,left.active12,right.active12),
			self := left),
		left outer,
		local);
	
	// For LLID12s that DID exist and are now not best, apply to keep
	old_keep_llid12s := join(
		distribute(add_previous_llids,hash64(bid,brid,blid,llid12)),
		distribute(other_llid12s_for_bidbridblid,hash64(bid,brid,blid,llid12)),
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid and
		left.llid12 = right.llid12,
		transform(Layout_LLID.LLID12.Linked,
			self.active12 := false,
			self := left),
		local);
	
	// All LLID12s
	export llid12s := (apply_new_best_llid12s + old_keep_llid12s)(llid12 != 0);

	// Normalize out our linkage set to create three records for each BEID: one with the BID only, one with BID/BRID, one with BID/BRID/BLID.
	normalized_linkage := normalize(linkage,3,
		transform({Layout_LLID.LLID9.Linked;boolean core;},
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
		distribute(old_llid9s(llid9 != 0),hash64(beid)),
		left.beid = right.beid and
		(
			(left.brid != 0 and left.blid != 0 and right.brid != 0 and right.blid != 0) or
			(left.brid != 0 and left.blid  = 0 and right.brid != 0 and right.blid  = 0) or
			(left.brid  = 0 and left.blid  = 0 and right.brid  = 0 and right.blid  = 0)
		),
		transform(Layout_LLID.LLID9.Linked,
			self.llid9 := right.llid9,
			self := left),
		local);
	
	// In order to check this, we need to roll up all of our records and count how many different BID/BRID/BLIDs each LLID9
	// is associated with.  Any that are associated with exactly ONE are okay by definition.  After that, if somehow an
	// LLID9 was split, we'll take the BID/BRID/BLID that has the most contributors from the original LLID9
	llid9_count_associated :=
		table(
			table(
				add_previous_llids,
				{llid9,bid,brid,blid,unsigned cnt := count(group)},
				llid9,bid,brid,blid,local),
			{llid9,bid,brid,blid,unsigned cnt := sum(group,cnt)},
			llid9,bid,brid,blid);
			
	// These are the BID/BRID/BLIDs "most closely associated" with old LLID9s
	llid9_associated_bidbridblids := dedup(sort(llid9_count_associated,llid9,-cnt,bid,brid,blid),llid9);
	
	// Now take all LLID9s associated with a BID/BRID/BLID, select the most frequent, then the lowest
	best_llid9_for_bidbridblid := dedup(sort(llid9_associated_bidbridblids,bid,brid,blid,-cnt,llid9),bid,brid,blid);
	
	// Let's find all the "non-winning" LLID9s for each BID/BRID/BLID... we'll use them to patch the old stuff.
	other_llid9s_for_bidbridblid := join(llid9_associated_bidbridblids,best_llid9_for_bidbridblid,
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid,
		transform(left),
		left only);
	
	// Now, apply the winning LLID9s back to the original set of records we created earlier.
	apply_known_best_llid9s :=
		join(
			distribute(deduped_normalized_linkage,hash64(bid,brid,blid)),
			distribute(best_llid9_for_bidbridblid,hash64(bid,brid,blid)),
			left.bid = right.bid and
			left.brid = right.brid and
			left.blid = right.blid,
			transform(recordof(deduped_normalized_linkage),
				self.llid9 := right.llid9,
				self.active9 := if(right.bid != 0,true,false),
				self := left),
			left outer,
			local);

	// Now we need to apply new LLID9
	// Get the maximum previously-assigned LLID9
	max_llid9 := max(old_llid9s,llid9);
	
	// Filter down to the BID/BRID/BLIDs that require a new LLID9
	need_llid9 := dedup(apply_known_best_llid9s(core and llid9 = 0),bid,brid,blid,all);
	hash_llid9 := project(sort(need_llid9,hash64(bid,brid,blid)),
		transform(Layout_LLID.LLID9.Linked,
			self.llid9 := max_llid9 + counter,
			self.active9 := true,
			self := left));
	
	// Now apply these
	apply_new_best_llid9s := join(
		distribute(apply_known_best_llid9s,hash64(bid,brid,blid)),
		distribute(hash_llid9,hash64(bid,brid,blid)),
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid,
		transform(Layout_LLID.LLID9.Linked,
			self.llid9 := if(right.llid9 = 0,left.llid9,right.llid9),
			self.active9 := if(right.llid9 = 0,left.active9,right.active9),
			self := left),
		left outer,
		local);
	
	// For LLID9s that DID exist and are now not best, apply to keep
	old_keep_llid9s := join(
		distribute(add_previous_llids,hash64(bid,brid,blid,llid9)),
		distribute(other_llid9s_for_bidbridblid,hash64(bid,brid,blid,llid9)),
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid and
		left.llid9 = right.llid9,
		transform(Layout_LLID.LLID9.Linked,
			self.active9 := false,
			self := left),
		local);

	// All LLID9s
	export llid9s := (apply_new_best_llid9s + old_keep_llid9s)(llid9 != 0);

end;