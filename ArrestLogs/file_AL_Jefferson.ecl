import ut;
export file_AL_Jefferson := 
	dataset('~thor_data400::in::arrlog::al::jefferson',
	ArrestLogs.Layout_AL_Jefferson,csv(heading(1),terminator('\n'), separator('|'), quote('')));
