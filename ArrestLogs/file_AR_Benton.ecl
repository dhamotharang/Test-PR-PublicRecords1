import ut;
export file_AR_Benton := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::ar::benton',
	ArrestLogs.layout_AR_Benton,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
