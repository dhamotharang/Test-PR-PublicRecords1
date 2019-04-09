IMPORT  Watchdog;
EXPORT fn_append_paw(DATASET(watchdog_best.Layouts.Layout_Best) best) := FUNCTION
	adl := DISTRIBUTE(Watchdog.BestPeopleAtWork, did);
  b := DISTRIBUTE(best, did);
	
	result := JOIN(b, adl, left.did=right.did, TRANSFORM(Watchdog_best.Layouts.Layout_Best,		
										self.bdid := IF(right.bdid=0,'',(string12)right.bdid);
										self := LEFT;),
									LEFT OUTER, KEEP(1), LOCAL);
									
	return result;
END;