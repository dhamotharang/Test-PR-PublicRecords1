IMPORT Doxie;
EXPORT  fn_getHdrRecByDid_wBestdates(DATASET(doxie.layout_references_hh) dids_hh) := FUNCTION
	hdr_recs  		:= doxie.header_records_byDID(dids_hh,true); //true to get Quick Header Data
	
	RECORDOF(hdr_recs) getBestDates(hdr_recs l, hdr_recs r) := TRANSFORM
		SELF.dt_first_seen := IF(l.dt_first_seen > 0 AND l.dt_first_seen < r.dt_first_seen,l.dt_first_seen, r.dt_first_seen);
		SELF := l;
		SELF := r;
		SELF := [];
	END;
	roll_recs	:= ROLLUP(SORT(hdr_recs, did, zip, prim_range, predir, prim_name, postdir, suffix, sec_range, -dt_last_seen), 
											LEFT.did 				= RIGHT.did 				AND
											LEFT.zip 		 		= RIGHT.zip					AND
											LEFT.prim_range = RIGHT.prim_range	AND
											LEFT.predir			= RIGHT.predir			AND
											LEFT.prim_name 	= RIGHT.prim_name		AND
											LEFT.postdir	 	= RIGHT.postdir			AND
											LEFT.suffix 		= RIGHT.suffix			AND
											LEFT.sec_range 	= RIGHT.sec_range,													
											getBestDates(LEFT,RIGHT));
	RETURN roll_recs;

END;	