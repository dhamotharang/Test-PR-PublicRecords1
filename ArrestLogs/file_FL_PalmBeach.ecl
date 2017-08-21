import ut;
export file_FL_PalmBeach := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::fl::palmbeach_old',
	ArrestLogs.Layout_FL_PalmBeach,csv(heading(1),terminator('\n'), separator('|'), quote('')));

