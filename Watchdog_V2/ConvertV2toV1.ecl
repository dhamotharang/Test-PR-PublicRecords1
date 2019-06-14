IMPORT dx_BestRecords, Watchdog;
EXPORT ConvertV2ToV1(dx_BestRecords.Constants.PERM_TYPE flavor) := FUNCTION

	k := dx_BestRecords.key_watchdog()((permissions & flavor) <> 0);

	result := PROJECT(k, TRANSFORM(Watchdog.Layout_best_flags - [run_date,filepos],
					self.did := left.did;
					reccounts := left.counts((permissions & flavor) <> 0);
					self.total_records := IF(COUNT(reccounts) = 0, left.total_records, reccounts[1].total_records);
					self := left;
					));
					
	return result;

END;
