IMPORT Doxie, ut;
EXPORT  fn_getHdrRecByDid_wBestdates(DATASET(doxie.layout_references_hh) dids_hh,
	                                   Address_Rank.IParams.BatchParams in_mod) := FUNCTION 
  hdr_recs := 
	   doxie.header_records_byDID(
	    dids            := dids_hh,
	    include_dailies := true, //true to get Quick Header Data
	    ReturnLimit     := in_mod.MaxInterHdrRecs);
	
	RECORDOF(hdr_recs) getBestDates(hdr_recs l, hdr_recs r) := TRANSFORM
		SELF.dt_first_seen := ut.min2(l.dt_first_seen, r.dt_first_seen);  //RQ-14100 fix
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