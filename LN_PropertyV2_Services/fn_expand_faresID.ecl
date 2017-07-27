import LN_PropertyV2;

export dataset(layouts.fid) fn_expand_faresID(dataset(layouts.fid) fids) := function

	// get ParcelIDs for specified FaresIDs
	pnum_d := join(
		fids, keys.deed,
		keyed(left.ln_fares_id = right.ln_fares_id),
		transform(layouts.search_pnum, self.pnum := LN_PropertyV2.fn_strip_pnum(right.apnt_or_pin_number)),
		limit(consts.max_raw, skip)
	);
	pnum_a := join(
		fids, keys.assessor,
		keyed(left.ln_fares_id = right.ln_fares_id),
		transform(layouts.search_pnum, self.pnum := LN_PropertyV2.fn_strip_pnum(right.apna_or_pin_number)),
		limit(consts.max_raw, skip)
	);
	pnum := pnum_d + pnum_a;
	
	// expand to all recs with matching ParcelID
	by_pnum := if( exists(pnum), Raw.get_fids_from_pnum(pnum) );
	
	// output(pnum_d,		named('pnum_d'));		// DEBUG
	// output(pnum_a,		named('pnum_a'));		// DEBUG
	// output(pnum,			named('pnum'));			// DEBUG
	// output(by_pnum,	named('by_pnum'));	// DEBUG
	
	return by_pnum;
	
end;