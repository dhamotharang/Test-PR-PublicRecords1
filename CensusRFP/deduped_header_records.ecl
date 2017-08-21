
IMPORT header, MDR, USAA, ut;
	 
	h := header.file_headers; // Distributed on hash(did)
	
	ds_header := IF(thorlib.nodes() = 400, h, DISTRIBUTE( h, HASH(did) ));

	// 1. Fix dt_first_seen, dt_last_seen. We want the earliest dt_first_seen available in the record, 
	// as well as a non-zero dt_last_seen, if possible.
	ds_adjusted_dates_seen := 
		PROJECT(
			ds_header, 
			TRANSFORM(
				header.Layout_Header, 
				SELF.dt_first_seen := header.get_header_first_seen(LEFT),
				SELF.dt_last_seen  := IF( LEFT.dt_last_seen > 0, LEFT.dt_last_seen, LEFT.dt_vendor_last_reported ),
				SELF               := LEFT
			));

	// 2. Do a 'strict' dedup on the address only. Preserve most distant dt_first_seen.
	std := SORT(ds_adjusted_dates_seen( dt_first_seen != 0, dt_last_seen != 0 ), /* by */
							did, st, zip, prim_name, prim_range, sec_range, dt_first_seen, LOCAL);	
							
	ddp := DEDUP(std, /* on */
							 did, st, zip, prim_name, prim_range, sec_range, LEFT.dt_first_seen <= RIGHT.dt_first_seen, LOCAL);

	// 3. Standardize similar-enough addresses for each DID. Rollup criteria must be somewhat fuzzy 
	// to account for addresses that are most likely the same. We don't want different-yet-same 
	// address records, since this product wants an accurate address history. Preserve the earliest
	// dt_first_seen for similar-enough addresses.
	ds_addrs := ROLLUP(ddp,
										 functions.addresses_are_similar_enough(LEFT,RIGHT),
										 TRANSFORM(header.Layout_Header, 
															 SELF.dob           := RIGHT.dob;
															 SELF.dt_first_seen := IF( LEFT.dt_first_seen <= RIGHT.dt_first_seen, LEFT.dt_first_seen, RIGHT.dt_first_seen );
															 SELF.dt_last_seen  := RIGHT.dt_last_seen;
															 SELF := IF( functions.addresses_are_similar_enough(LEFT,RIGHT), LEFT, RIGHT )), 
										 LOCAL);

	ds_addrs_resorted := SORT(ds_addrs, did, dt_first_seen, dt_last_seen, LOCAL);

	// 4. Add sequence number for later calculations.

	layout_header_plus_seq := RECORD
		UNSIGNED8 seq    := 0;
		header.Layout_Header;
	END;

	ds_addrs_plus := PROJECT(ds_addrs_resorted, layout_header_plus_seq);

	layout_header_plus_seq xfm_add_seq_no(layout_header_plus_seq l, layout_header_plus_seq r) := 
		TRANSFORM
			SELF.seq           := IF( l.did = r.did, l.seq + 1, 1 );
			SELF.dt_first_seen := r.dt_first_seen;
			SELF.dt_last_seen  := r.dt_last_seen;
			SELF               := r;
		END;
			
	ds_addrs_plus_seq := ITERATE(ds_addrs_plus, xfm_add_seq_no(LEFT,RIGHT), LOCAL);

EXPORT deduped_header_records := ds_addrs_plus_seq : persist('deduped_header_records');
