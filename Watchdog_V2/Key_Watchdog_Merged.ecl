IMPORT dx_BestRecords;

	ds := PROJECT(watchdog_V2.File_Merged, Watchdog_V2.Layout_Key_Merged);

EXPORT Key_Watchdog_Merged  := dx_BestRecords.key_watchdog();
