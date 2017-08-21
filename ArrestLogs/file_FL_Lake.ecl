import ut;
export file_FL_Lake := 
	dataset(ut.foreign_prod +'~thor_data400::in::arrlog::fl::lake',
	ArrestLogs.Layout_FL_Lake,csv(heading(1),terminator('\n'), separator('|'), quote('')));