import ut;
export file_CA_Riverside := 
	dataset(ut.foreign_prod +'~thor_data400::in::arrlog::ca::riverside',
	ArrestLogs.Layout_CA_Riverside,csv(heading(1),terminator('\n'), separator('|'), quote('')));