import alerts;

export alert_layouts_ext := MODULE

	export layout_report_hash_seq := RECORD(alerts.layouts.layout_report_hash)
		unsigned2 alertSeq;
	END;
																						
	// for now, only modifying the datasets that require this finer granularity
	export layout_report_hashes_ext := 
		RECORD(alerts.layouts.layout_report_hashes 
					- [listedphone_hashes,crim_hashes,airc_hashes,boat_hashes,vehicle_hashes]), maxlength(400000)
		DATASET(layout_report_hash_seq) listedphone_hashes;
		DATASET(layout_report_hash_seq) crim_hashes;
		DATASET(layout_report_hash_seq) airc_hashes;
		DATASET(layout_report_hash_seq) boat_hashes;
		DATASET(layout_report_hash_seq) vehicle_hashes;
	END;
	
	
END;