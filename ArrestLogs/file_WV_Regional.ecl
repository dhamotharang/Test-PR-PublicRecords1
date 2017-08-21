import ut;
export file_WV_Regional := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::wv::regional',
	ArrestLogs.Layout_WV_Regional,csv(heading(1),terminator('\n'), separator('|'), quote('')));