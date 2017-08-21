import ut;

export file_TX_Brazoria:= module

export old_f := 
	dataset('~thor_data400::in::arrlog::tx::brazoria',
	ArrestLogs.Layout_TX_Brazoria.old_format,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
export new_f := 
   dataset('~thor_data400::in::arrlog::tx::brazoria::new',
	ArrestLogs.Layout_TX_Brazoria.new_format,csv(heading(1),terminator('\n'), separator('|'), quote('')));


end;