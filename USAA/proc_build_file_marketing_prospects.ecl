
IMPORT header, MDR, USAA, ut;

/* Ensure ds_header below is defined as a file source that is eligible for direct marketing. 
   (See KBM.Filtered_File) */
	 
h := header.file_headers_NonGLB; // Comes distributed: IF(thorlib.nodes() = 400, ds,distribute(ds,hash(did)))
is_marketing := mdr.Source_is_Marketing_Eligible(h.src, h.vendor_id, h.st, h.county, h.dt_nonglb_last_seen, h.dt_first_seen);
ds_header := h( is_marketing );

// 1. Obtain the entities that have lived at some point in a zipcode on or near a milbase,
// or whose city_name contains 'APO' or 'FPO', indicating overseas military deployment.
ds_header_filtered := ds_header( (zip IN USAA.zipcodes_proximity_milbase OR
                                  regexfind('^APO$| APO$| APO |^APO |^FPO$| FPO$| FPO |^FPO ',city_name)) );

// 2. Join back to header to obtain complete address history for qualified entities.
ds_filtered_entities_deduped := DEDUP(SORT(ds_header_filtered, DID, LOCAL), DID, LOCAL);

ds_filtered_entities_all_addresses := JOIN(ds_header, ds_filtered_entities_deduped,
                                           RIGHT.did = LEFT.did,
														               TRANSFORM(header.Layout_Header, SELF := LEFT),
														               INNER, LOCAL);

// 3. Fix dt_first_seen, dt_last_seen. We want the earliest dt_first_seen available in the record, 
// as well as a non-zero dt_last_seen, if possible.
ds_adjusted_dates_seen := PROJECT(ds_filtered_entities_all_addresses, 
                                  TRANSFORM(header.Layout_Header, 
                                            SELF.dt_first_seen := header.get_header_first_seen(LEFT),
																					  SELF.dt_last_seen  := IF( LEFT.dt_last_seen > 0, LEFT.dt_last_seen, LEFT.dt_vendor_last_reported ),
																					  SELF               := LEFT));

// 4. Do a 'strict' dedup on the address only. Don't use city, since it can vary. Preserve most
// distant dt_first_seen.

std := SORT(ds_adjusted_dates_seen( dt_first_seen != 0, dt_last_seen != 0 ), /* by */
            did, st, zip, prim_name, prim_range, sec_range, dt_first_seen, LOCAL);	
						
ddp := DEDUP(std, /* on */
						 did, st, zip, prim_name, prim_range, sec_range, LEFT.dt_first_seen <= RIGHT.dt_first_seen, LOCAL);

// 5. Standardize similar-enough addresses for each DID. Rollup criteria must be somewhat fuzzy 
// to account for addresses that are most likely the same. We don't want different-yet-same 
// address records, since this product wants an accurate address history. Preserve the earliest
// dt_first_seen for similar-enough addresses.
ds_addrs := ROLLUP(ddp,
                   USAA.functions.addresses_are_similar_enough(LEFT,RIGHT),
                   TRANSFORM(header.Layout_Header, 
                             SELF.dob           := RIGHT.dob;
		                         SELF.dt_first_seen := IF( LEFT.dt_first_seen <= RIGHT.dt_first_seen, LEFT.dt_first_seen, RIGHT.dt_first_seen );
		                         SELF.dt_last_seen  := RIGHT.dt_last_seen;
                             SELF := IF( USAA.functions.addresses_are_similar_enough(LEFT,RIGHT), LEFT, RIGHT )), 
                   LOCAL);

ds_addrs_resorted := SORT(ds_addrs, did, dt_first_seen, dt_last_seen, LOCAL);

// 6. Add sequence number for later metrics calculations.

ds_addrs_plus := PROJECT(ds_addrs_resorted, USAA.layout_header_plus_seq);

USAA.layout_header_plus_seq xfm_add_seq_no(USAA.layout_header_plus_seq l, USAA.layout_header_plus_seq r) := 
	TRANSFORM
		SELF.seq           := IF( l.did = r.did, l.seq + 1, 1 );
		SELF.dt_first_seen := r.dt_first_seen;
		SELF.dt_last_seen  := r.dt_last_seen;
		SELF               := r;
	END;
		
ds_addrs_plus_seq := ITERATE(ds_addrs_plus, xfm_add_seq_no(LEFT,RIGHT), LOCAL);

EXPORT proc_build_file_marketing_prospects := ds_addrs_plus_seq : persist('~persist::file_USAA_marketing_prospects_all');
