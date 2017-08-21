import ut;

export File_TX_Denton_Individuals := dataset('~thor_data400::in::arrlog::20061103::tx_denton_individuals.txt',
	ArrestLogs.Layout_TX_Denton_Individuals,csv(heading(1),terminator('\n'), separator('|'), quote('')));