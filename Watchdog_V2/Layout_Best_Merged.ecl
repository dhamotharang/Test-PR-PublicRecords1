IMPORT Watchdog;

EXPORT Layout_Best_Merged := RECORD
	unsigned6		did;
  UNSIGNED4 bitmap_permissions;
  string14 str_permissions;
	DATASET(Watchdog_v2.Layout_records)	counts;
	Watchdog.Layout_best_flags - [did,filepos];
END;