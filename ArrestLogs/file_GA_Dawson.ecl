import ut;
export file_GA_Dawson := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::ga::dawson',
	ArrestLogs.layout_GA_Dawson,csv(heading(1),terminator('\n'), separator('|'), quote('')));
