import ut;
export File_WA_Kitsap := dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::WA::Kitsap',	
				ArrestLogs.layout_WA_Kitsap,csv(heading(1),terminator('\n'), separator('|'), quote('')));