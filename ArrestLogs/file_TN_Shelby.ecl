import ut;
export file_TN_Shelby := 
	dataset('~thor_data400::in::arrlog::tn::shelby',
	ArrestLogs.layout_TN_Shelby,csv(heading(1),terminator('\n'), separator('|'), quote('')));