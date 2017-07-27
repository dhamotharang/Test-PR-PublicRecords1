export mac_ProcessAlerts(inrecs,attr_prefix,outrecs) := MACRO
import alerts;
	
	// shorter names
	layout_hash := alerts.layouts.layout_hash;
	
	// preserve input layout for slimming back later 
	out_layout := recordof(inrecs);
	
	 //need to limit to the max before checking alerts
	recs_ltd := choosen(inrecs,MaxResults_val);
     
  ah := alerts.inputs;
	
	// isolate the input hash dataset
	layout_hash getHashes(layout_hash R) := TRANSFORM
		SELF := R;
	END;
	in_hashes := NORMALIZE(ah.input_srch_hashes, LEFT.hashes, getHashes(RIGHT));

	input_version := ah.input_srch_hashes[1].version;
	
	// call appropriate attr to calc search_alerts
  results_hash := attr_prefix.search_alerts(recs_ltd,input_version);

	//produce only the new results, comparing hashes 
  new_res := JOIN(results_hash, in_hashes, LEFT.hashval = RIGHT.hashval,
   								TRANSFORM(out_layout, SELF := LEFT), LEFT ONLY);

	// when versioning is needed, calculate current version of hashes (can use results if input_version 
	// is current, otherwise need to calc current hashes for return here)
	hashes := PROJECT(results_hash, layout_hash);
	
	// as a stopgap, accumulate hashes and save the ones they've already seen plus the new ones
	// this will help minimize the effect of any oscillation of hashval calculation until that problem is fixed
	combined_hashes := dedup(sort(in_hashes + hashes, hashval), hashval); 

	out_hashes := DATASET([{attr_prefix.CURRENT_VERSION, combined_hashes}], alerts.layouts.layout_srch_hashes);
	
  if(ah.return_hashes, output(out_hashes, NAMED('Hashes'), EXTEND));

  outrecs := if(ah.return_hashes, new_res, inrecs);

ENDMACRO;