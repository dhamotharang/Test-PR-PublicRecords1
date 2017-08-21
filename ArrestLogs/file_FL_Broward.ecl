import ut;
export file_FL_Broward := 
	dataset('~thor_data400::in::arrlog::fl::broward',
	ArrestLogs.Layout_FL_Broward,csv(heading(1),terminator('\n'), separator('|'), quote('')));

