IMPORT Watchdog;
EXPORT fn_append_bankruptcy(DATASET(watchdog_best.Layouts.Layout_Best) best) := FUNCTION
	bankruptcy := DISTRIBUTE(Watchdog.bankruptcy, did);
  b := DISTRIBUTE(best, did);
	
	result := JOIN(b, bankruptcy, left.did=right.did, TRANSFORM(Watchdog_best.Layouts.Layout_Best,		
										self.Bkrupt_CrtCode_CaseNo := RIGHT.CourtCaseSeq;
										self.main_count := RIGHT.main_cnt;
										self.search_count := RIGHT.search_cnt;
										self := LEFT;),
									LEFT OUTER, KEEP(1), LOCAL);
									
	return result;
END;

