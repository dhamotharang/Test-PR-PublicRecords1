import ut;
export file_TX_Brazoria_old := 
	dataset('~thor_data400::in::thru_20061211::arrlog::tx_brazoria.txt',
	ArrestLogs.Layout_TX_Brazoria_old,csv(heading(1),terminator('\n'), separator('|'), quote('')));