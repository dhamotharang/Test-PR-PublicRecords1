export mac_setupAlerts(in_layout, calc_func, version) := MACRO
import alerts;
	
	export CURRENT_VERSION := version;
	
	shared layout_with_hashes := RECORD(in_layout)
		alerts.layouts.layout_hash;
  END;

  layout_with_hashes calcSearchHashes(in_layout l) := TRANSFORM
   	SELF.hashval := (string) calc_func(l);
   	SELF := l;
  END;
	
	export DATASET(layout_with_hashes) search_alerts (DATASET(in_layout) recs, unsigned1 ver) := FUNCTION
		// when versioning is needed, take the input version and determine whether to call
		// current hash calc code, or previous hash calc code
		res := PROJECT(recs, calcSearchHashes(LEFT));
		RETURN res;
	END;

  alerts.layouts.layout_hashval calcReportHashes(in_layout l) := TRANSFORM
		SELF.hashval := calc_func(l);
	END;

	export DATASET(alerts.layouts.layout_report_hash) report_alerts (DATASET(in_layout) recs, boolean curVersion = true) := FUNCTION
		// when versioning is needed, use curVersion to determine whether to call
		// current hash calc code, or previous hash calc code (and set version number appropriately)
		hashvals := PROJECT(recs, calcReportHashes(LEFT));
		RETURN DATASET([{CURRENT_VERSION,SUM(hashvals,hashval)}],alerts.layouts.layout_report_hash);
	END;

ENDMACRO;