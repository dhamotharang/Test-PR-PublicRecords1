import ut;
export File_WA_clark  := dataset(ut.foreign_prod + '~thor_data400::in::arrlog::wa::clark',	
				Layout_WA_clark,csv(heading(1),terminator('\n'), separator('|')));