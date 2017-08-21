import ut;
export file_CA_LosAngeles := 
	dataset('~thor_data400::in::arrlog::ca::losangeles',
	ArrestLogs.Layout_CA_LosAngeles,csv(heading(1),terminator('\n'), separator('|'), quote('')));