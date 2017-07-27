export layouts := MODULE
	// layouts
	export layout_hashval := RECORD
		unsigned8 hashval;
	END;
	
	export layout_hash := RECORD
		STRING25 hashval;
	END;
	
	// need a maxlength or maxcount
	export layout_srch_hashes := RECORD
		unsigned1 version;
		DATASET (layout_hash) hashes {maxcount(3000)};
	END;

	export layout_report_hash := RECORD, maxlength(1000)
		unsigned1 version;
		layout_hash;
	END;

	export layout_report_hashes := RECORD, maxlength(200000)
		// should an alert should be triggered only when a new item is associated
		// -- this may help address the issue with "best oscillation" from build to build
		
		DATASET(layout_report_hash) name_hashes;
		DATASET(layout_report_hash) ssn_hashes;
		DATASET(layout_report_hash) status_hashes;
		DATASET(layout_report_hash) address_hashes;
		DATASET(layout_report_hash) phone_hashes;
		DATASET(layout_report_hash) asset_hashes;
		DATASET(layout_report_hash) prop_hashes;
		DATASET(layout_report_hash) bkrp_hashes;
		DATASET(layout_report_hash) ucc_hashes;
		DATASET(layout_report_hash) lien_hashes;
		DATASET(layout_report_hash) license_hashes;
		DATASET(layout_report_hash) crim_hashes;
		DATASET(layout_report_hash) sexoff_hashes;
		DATASET(layout_report_hash) corp_hashes;
		DATASET(layout_report_hash) associate_hashes;
		DATASET(layout_report_hash) listedphone_hashes;
		DATASET(layout_report_hash) airc_hashes;
		DATASET(layout_report_hash) boat_hashes;
		DATASET(layout_report_hash) vehicle_hashes;
	END;
	
	export layout_locreport_hashes := RECORD, maxlength(20000)
		DATASET(layout_report_hash) prop_hashes;
		DATASET(layout_report_hash) assoc_hashes;
	END;
END;