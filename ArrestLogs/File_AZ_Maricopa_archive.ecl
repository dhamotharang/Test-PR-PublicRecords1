import ut;

export File_AZ_Maricopa_archive := 
	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::20070212::az_maricopa.txt',
	ArrestLogs.layout_AZ_Maricopa_archive ,csv(heading(1),terminator('\n'), separator('|'), quote('')));