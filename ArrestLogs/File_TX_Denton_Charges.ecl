import ut;

export File_TX_Denton_Charges := dataset('~thor_data400::in::arrlog::20061103::tx_denton_charges.txt',
	ArrestLogs.Layout_TX_Denton_Charges,csv(heading(1),terminator('\n'), separator('|'), quote('')));