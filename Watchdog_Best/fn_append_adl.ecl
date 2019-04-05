IMPORT Header;
EXPORT fn_append_adl(DATASET(watchdog_best.Layouts.Layout_Best) best) := FUNCTION
	adl := DISTRIBUTE(Header.fn_ADLSegmentation(header.file_headers).core_check_pst, did) : persist('Persist::Watchdog_adl');
  b := DISTRIBUTE(best, did);
	
	result := JOIN(b, adl, left.did=right.did, TRANSFORM(Watchdog_best.Layouts.Layout_Best,		
										self.adl_ind := right.ind;
										self := LEFT;),
									LEFT OUTER, KEEP(1), LOCAL);
									
	return result;
END;
