// The following function determines who the candidates are for a particular product. That is, it first
// assesses whether the product specified in the config module (mod_cfg) ought to be run given the value
// of the product_mask for the current monitoring job. If it is, all portfolio entities whose profile
// contains the specified product are run against the Candidate Generation Mechanism described in the 
// config module (i.e. mod_cfg.generate_candidates( )).
//
// Then, we create a new candidate history by distributing the new candidates with the history candidates; 
// merging the two files; sorting by pid, rid, hid, timestamp and hashvalue. The timestamp is NOT sorted
// in reverse order (-timestamp) intentionall.  This allows the dedup to keep the current history record
// if there are no changes to the hash value. 
//
// NOTE: Those candidates that are New or Changed 
// are filtered later and returned to the Batch R3 system. The new candidate history will be written 
// to file later also.
EXPORT fn_monitor_for_candidates( AccountMonitoring.i_Monitoring_Product_Config mod_cfg,
											 STRING in_timestamp) := 
	FUNCTION
		
		emptySet := DATASET([],AccountMonitoring.layouts.history);
		ds_candidates := IF( mod_cfg.product_is_in_mask, 
		                     mod_cfg.generate_candidates( ), 
												 emptySet);
		
      // Project the candidates returned from this monitoring run into the history layout
		ds_candidates_for_history := PROJECT(ds_candidates,
			TRANSFORM(AccountMonitoring.layouts.history,
				SELF.timestamp := in_timestamp[2..9] + in_timestamp[11..16],
				SELF := LEFT));
		
      // Once the both files are in the same layout: distribute them by pid, rid and hid
		// concatinate the two (current candidates and the history candidates for that product) files 
		// Sort the combined file by pid, rid, hid, timestamp and hash value (having the time stamp in the sort
		// puts the history file candidate record before a new candidate record with the same hash value.)
		// So, if a there is no change to the hash value, the NEW candidate is deduped out of the dataset.
		// On the other hand, if the hash value is different, both the history and new candidate records will be 
		// returned in the dataset.
		// Finally, dedup the file by pid, rid, hid and hash value.   
		candidates_dist := DISTRIBUTE(ds_candidates_for_history, HASH32(pid, rid, hid));
		history_dist    := DISTRIBUTE(mod_cfg.history_file, HASH32(pid, rid, hid));
		merged_history  := candidates_dist + history_dist;
		sorted_history  := SORT(merged_history,pid,rid,hid,timestamp,hash_value,LOCAL);
		deduped_history := DEDUP(sorted_history,pid,rid,hid,hash_value,LOCAL);
		
		RETURN deduped_history;
		
	END;