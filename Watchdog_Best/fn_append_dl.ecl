IMPORT Watchdog;
EXPORT fn_append_dl(DATASET(watchdog_best.Layouts.Layout_Best) best) := FUNCTION
	dl := DISTRIBUTE(Watchdog.BestDL, did);
  b := DISTRIBUTE(best, did);
	
	result := JOIN(b, dl, left.did=right.did, TRANSFORM(Watchdog_best.Layouts.Layout_Best,		
										self.dl_number := RIGHT.dl_number;
										self := LEFT;),
									LEFT OUTER, KEEP(1), LOCAL);
									
	return result;
END;
