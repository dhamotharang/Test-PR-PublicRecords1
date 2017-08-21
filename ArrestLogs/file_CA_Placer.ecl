import ut;
export file_CA_Placer := 
	dataset('~thor_data400::in::arrlog::ca::placer',
	ArrestLogs.Layout_CA_Placer,csv(heading(1),terminator('\n'), separator('|'), quote('')));
