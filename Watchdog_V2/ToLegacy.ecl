// ****
// Convert the merged file to legacy format
// ****
IMPORT Watchdog;
EXPORT ToLegacy(unsigned4 permission) := 
	PROJECT(Watchdog_V2.File_Merged((bitmap_Permissions & permission) <> 0), TRANSFORM(Watchdog.layout_best,
						self.total_records := left.counts((bitmap_Permissions & permission) <> 0)[1].total_records;
						self := LEFT;));