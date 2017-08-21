import ut;
export file_CO_Pitkin_new := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::20081013::co_pitkin.txt',
	ArrestLogs.layout_CO_Pitkin_new,csv(heading(1),terminator('\n'), separator('|'), quote('')));