import ut;
export file_NM_Bernalillo := 
	dataset('~thor_data400::in::arrlog::nm::bernalillo',
	ArrestLogs.layout_NM_Bernalillo,csv(heading(1),terminator('\n'), separator('|'), quote('')));