export alert_layouts := MODULE

	// layouts
	export layout_hashval := RECORD
		unsigned8 hashval;
	END;
	
	export layout_hash := RECORD, maxlength(50)
		STRING hashval;
	END;
	
	export layout_hashes := RECORD, maxlength(100000)
		// need to maintain a version for the entire record, but not for each hash set  (confirm this)
		STRING version;
		
		// should an alert should be triggered only when a new item is associated
		// -- this may help address the issue with "best oscillation" from build to build
		// -- does this apply to other things?  Only show when the entity gets a new vehicle, but not
		// when one disappears?
		
		DATASET (layout_hash) name_hashes;

		DATASET (layout_hash) address_hashes;
		DATASET (layout_hash) asset_hashes;
		DATASET (layout_hash) prop_hashes;
		DATASET (layout_hash) bkrp_hashes;
		DATASET (layout_hash) ucc_hashes;
		DATASET (layout_hash) lien_hashes;
		DATASET (layout_hash) license_hashes;
		DATASET (layout_hash) corp_hashes;
		DATASET (layout_hash) associate_hashes;
	END;
END;