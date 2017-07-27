import ut;
export File_LA_Lafayette  := dataset(ut.foreign_prod + '~thor_data400::in::arrlog::la::lafayette',	
				Layout_LA_Lafayette,csv(heading(1),terminator('\n'), separator('|')));
				
				