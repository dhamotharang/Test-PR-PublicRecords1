import ut;
export file_GA_Bibb := 
	dataset(ut.foreign_prod +'~thor_data400::in::arrlog::ga::bibb',
	ArrestLogs.Layout_GA_Bibb,csv(heading(1),terminator('\n'), separator('|'), quote('')));