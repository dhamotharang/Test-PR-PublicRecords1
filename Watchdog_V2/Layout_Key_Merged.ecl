IMPORT Watchdog;

EXPORT Layout_Key_Merged := RECORD
	unsigned6		did;
	Watchdog.Layout_Best_v2 - [did,total_records];
  UNSIGNED8 bitmap_permissions;
  string14 str_permissions;
	DATASET(Watchdog_v2.Layout_records)	counts;
  Watchdog.Layout_best_flags - filepos;
	//Watchdog_V2.Layout_Best_Merged - did;
	//UNSIGNED8 __filepos {VIRTUAL(FILEPOSITION)};
END;