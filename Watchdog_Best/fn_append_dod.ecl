IMPORT Watchdog;
EXPORT fn_append_dod (DATASET($.Layouts.Layout_Best) best) := FUNCTION
	d := DISTRIBUTE(Watchdog.Death, did);
  b := DISTRIBUTE(best, did);
	
	result := JOIN(b, d, left.did=right.did, TRANSFORM($.Layouts.Layout_Best,		
										self.dod := RIGHT.dod;
										self := LEFT;),
									LEFT OUTER, KEEP(1), LOCAL);
									
	return result;
END;