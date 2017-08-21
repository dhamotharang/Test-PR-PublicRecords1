import ut;
export file_AZ_Maricopa := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::az::maricopa',
	ArrestLogs.layout_AZ_Maricopa_new ,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
