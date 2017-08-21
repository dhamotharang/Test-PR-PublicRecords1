import ut;
export file_CO_Weld := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::co::weld_old',
	ArrestLogs.layout_CO_Weld,csv(heading(1),terminator('\n'), separator('|'), quote('')));
