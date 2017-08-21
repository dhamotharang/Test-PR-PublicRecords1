
// The following function rolls up each candidate and adds together the product_mask value. There
// will be one candidate record for each product that received a hit due to a change since the last
// monitoring job. Each fn_cgm_ function is responsible for outputting its product_mask value, so 
// we'll see something like the following: 
//
// Given a monitoring job against the bankruptcy, address and phone products (meaning that the input
// product mask is 13), Thor returns two candidate records for a particular portfolio entity, say, 
// for bankruptcy and address. Since the product_mask value for bankruptcy is 1, and for address 
// is 8, the rolled up product_mask value for the entity shall be 9. This value allows the Batch R3
// system to employ a bit-testing function to ascertain which products changed for that entity.

EXPORT DATASET(AccountMonitoring.layouts.results) fn_rollup_candidates( DATASET(AccountMonitoring.layouts.history) candidates) := 
	FUNCTION
		
		rec := AccountMonitoring.layouts.history;
		
		rec xfm_rollup_product_hits(rec l, rec r) :=
			TRANSFORM
				SELF.product_mask := l.product_mask + r.product_mask;
				SELF              := r;
			END;

		candidates_sorted := SORT(DISTRIBUTED(candidates, HASH64(pid, rid, hid)), pid, rid, hid, LOCAL); 

		candidates_rolled := ROLLUP(candidates_sorted, xfm_rollup_product_hits(LEFT, RIGHT), pid, rid, hid, LOCAL);
																
		RETURN PROJECT(candidates_rolled, AccountMonitoring.layouts.results);
		
	END;
	