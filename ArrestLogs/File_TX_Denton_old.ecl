import ut;

export File_TX_Denton_old := 
	dataset('~thor_data400::in::arrlog::tx::denton_old',
	ArrestLogs.Layout_TX_Denton_old,csv(heading(1),terminator('\n'), separator('|'), quote('')));