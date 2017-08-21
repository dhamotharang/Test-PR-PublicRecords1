import ut;
export file_CO_Pitkin := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::co::pitkin',
	ArrestLogs.layout_CO_Pitkin,csv(heading(1),terminator('\n'), separator('|'), quote('')));