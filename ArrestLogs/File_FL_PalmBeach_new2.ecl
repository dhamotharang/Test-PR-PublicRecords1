import ut;

export file_FL_PalmBeach_new2 := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::fl::palmbeach',
	ArrestLogs.Layout_FL_PalmBeach_new2,csv(heading(1),terminator('\n'), separator('|'), quote('')));