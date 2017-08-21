import ut;
export file_CO_Weld_new := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::co::weld',
	ArrestLogs.layout_CO_Weld_new,csv(heading(1),terminator('\n'), separator('|'), quote('')));
