import ut;
export file_CA_Tehama := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::ca::tehama',
	ArrestLogs.layout_CA_Tehama,csv(heading(1),terminator('\n'), separator('|'), quote('')));
