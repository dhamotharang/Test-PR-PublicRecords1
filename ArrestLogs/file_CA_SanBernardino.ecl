import ut;
export file_CA_SanBernardino := 
	dataset('~thor_data400::in::arrlog::ca::san_bernardino',
	ArrestLogs.Layout_CA_SanBernardino,csv(heading(1),terminator('\n'), separator('|'), quote('')));

