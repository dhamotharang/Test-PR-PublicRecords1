import ut;

export File_TX_Denton_Alias := dataset('~thor_data400::in::arrlog::20061103::tx_denton_alias.txt',
	ArrestLogs.Layout_TX_Denton_Alias,csv(heading(1),terminator('\n'), separator('|'), quote('')));;