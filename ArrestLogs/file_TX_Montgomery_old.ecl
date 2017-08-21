import ut;
export file_TX_Montgomery_old := 
	dataset('~thor_data400::in::thru_20060929_raw::arrlog::tx_montgomery.txt',
	ArrestLogs.Layout_TX_Montgomery_old,csv(heading(1),terminator('\n'), separator('|'), quote('')));