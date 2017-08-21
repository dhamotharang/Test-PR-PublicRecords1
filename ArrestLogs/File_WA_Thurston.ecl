Import ut;
export File_WA_Thurston := dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::WA::thurston_2',	
				 layout_WA_thurston,csv(heading(1),terminator('\n'), separator('|'), quote('')));