import ut;
export file_TX_Cameron := 
	dataset('~thor_data400::in::arrlog::tx::cameron',
	ArrestLogs.Layout_TX_Cameron,csv(heading(1),terminator('\n'), separator('|'), quote('')));