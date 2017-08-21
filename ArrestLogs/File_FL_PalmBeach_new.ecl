import ut;

export file_FL_PalmBeach_new := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::20080414::fl_palmbeach.txt',
	ArrestLogs.Layout_FL_PalmBeach_new,csv(heading(1),terminator('\n'), separator('|'), quote('')));