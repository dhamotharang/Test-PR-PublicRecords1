import ut;
export file_OR_Yamhill := 
	dataset('~thor_data400::in::arrlog::or::yamhill',
	ArrestLogs.Layout_OR_Yamhill,csv(heading(1),terminator('\n'), separator('|'), quote('')));